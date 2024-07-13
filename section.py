#!/usr/bin/python3
# -*- coding: utf8 -*-
"""
说明: 环境变量`SEC_TION`账号密码`-`分割，多账户用;隔开[例如：aaa-bbb&ccc-ddd]
"""

import base64, json
import os, time, random
from playwright.sync_api import sync_playwright
import requests
try:
    from sendNotify import send
except:
    def send(*args):
        print("未找到通知文件sendNotify.py不启用通知！")

List = []

# 内置Python环境变量[纯Python环境可启用]
os.environ['SEC_TION'] = os.environ.get('SEC_TION', "default_value")

# os.environ['SVG_URL'] = "http://127.0.0.1:3001/svg"

# html元素定位
user_name = "#username"  # 账户输入框id
pass_word = "#password"  # 密码输入框id
captcha = "[alt='captcha']"  # svg路径验证码alt
captcha_inputbox = "#captcha"  # 验证码输入框id
user_button = "[type='submit']"  # 账户提交按钮type "//div[2]/button[@type='submit']"
passwd_button = "//div[3]/button[@type='submit']"  # 密码提交按钮
error_html = ".error-body"  # 限制访问页面class
error_pwd = "#error-element-password"  # 密码错误提醒id
error_login = "#prompt-alert"  # 连续登陆被阻止
email_name = "[aria-haspopup='listbox']"  # 账户主页面aria-label
active_state = "[data-testid='CheckCircleOutlineIcon']"  # 应用处于活跃状态data-testid
delay_time = "#hibernation-extend-button:text('Postpone hibernation')"  # 可延长休眠id和text "text=Postpone hibernation"
wake_dormant = "#hibernation-extend-button:text('Wake project')"  # 唤醒应用id和text "text=Wake project"
pop_up = "[role='presentation']"  # 续期/激活弹窗
renew_button = "text=Extend anyway"  # 续期按钮text / "text=Turn off"


def chrome_start():
    playwright = sync_playwright().start()
    browser = playwright.firefox.launch(
        channel="firefox",
        headless=True,  # 无头模式
        args=['--start-maximized'],
        slow_mo=1000
    )
    return browser


# 获取验证码
def svg_code(b64_svg):
    svg_path = base64.b64decode(b64_svg).decode('utf-8') # 解密base64路径
    if 'SVG_URL' in os.environ:
        captcha_url = os.environ['SVG_URL'] # 自定义打码接口
    else:
        captcha_url = "https://svgcfwk.grbhq.tk/svg" # 使用默认接口
    data = {"svgpath": svg_path}
    res = requests.post(captcha_url, headers={'content-type': 'application/json'}, data=json.dumps(data)) # 发送svg路径，获取验证码
    if res.status_code == 200:
        List.append(res.json())
        return res.json()
    else:
        print("打码服务无法连接，请稍后再试或使用自定义打码url！！！")


# 截取无法识别的验证码图片到svg目录下
def screen_svg(page, svgcode_data):
    unsvgcode_img = page.query_selector(captcha)
    if 'unsvgcode' in svgcode_data and unsvgcode_img:
        unsvgcode_list = svgcode_data.get("unsvgcode")
        img_name = '_'.join([f"{item['num']}-{item['length']}" for item in unsvgcode_list])  # 格式化拼接num和length
        unsvgcode_img.screenshot(path=f'./svg/{svgcode_data.get("svgcode")}_{img_name}.png')
    elif unsvgcode_img:
        unsvgcode_img.screenshot(path=f'./svg/{svgcode_data.get("svgcode")}.png')


def svg_code_input(page, input_box, value, submit_button):
    try:
        capt_cha = True  # 存在验证码
        req_limit = False  # 不存在限制访问
        i = 1
        err_times = 6  # 打码重试次数[访问次数连续超过12次左右，section将限制访问]
        while capt_cha and not req_limit:
            page.fill(input_box, value)  # 输入账号/密码
            b = page.locator(captcha).get_attribute('src').split(',')[1]
            svgcode_data = svg_code(b)
            svgcode = svgcode_data.get('svgcode') if 'svgcode' in svgcode_data else None  # 获取svg验证码
            if len(svgcode) == 6:
                page.fill(captcha_inputbox, svgcode)  # 输入验证码
                page.click(submit_button)  # 点击提交
                page.wait_for_load_state("networkidle", timeout=20 * 1000)
                capt_cha = page.query_selector_all(captcha)
                req_limit = page.query_selector_all(error_html)
                if capt_cha and i < err_times:
                    print(f"第{i}次获取验证码出错")
                    i += 1
                elif i == err_times:
                    List.append(f"第{i}次验证错误，错误次数过多，停止运行脚本")
                    return 1
                elif req_limit:
                    print(f"连续错误次数过多，访问被限制，等待10s！！！")
                    page.wait_for_timeout(10000)
                    page.reload()  # 刷新页面
                    page.wait_for_load_state("networkidle", timeout=20 * 1000)
                    capt_cha = page.query_selector_all(captcha)
                    req_limit = None
                else:
                    List.append(f"第{i}次获取验证码成功")
                    break
            elif svgcode == None or len(svgcode) < 6:
                print("无法识别验证码或验证码识别不全")
                screen_svg(page, svgcode_data)  # 截取验证码图片
                page.reload()
                page.wait_for_load_state("networkidle", timeout=20 * 1000)
                capt_cha = page.query_selector_all(captcha)
                req_limit = page.query_selector_all(error_html)

            else:
                page.reload()
                time.sleep(10)
                capt_cha = page.query_selector_all(captcha)
                req_limit = page.query_selector_all(error_html)
        else:
            if not req_limit:
                print("验证码消失！")
                page.fill(input_box, value)  # 输入账户/密码
                page.click(submit_button)  # 点击提交
            else:
                List.append("访问已被限制，结束页面")
                return 1
    except Exception as err:
        List.append(f'行号：{err.__traceback__.tb_lineno}\n错误信息：{err}')


def login(browser, usr, pwd):
    context = browser.new_context(
        user_agent='Mozilla/5.0 (iPhone; CPU iPhone OS 13_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148', no_viewport=True) # 设置ua
    page = context.new_page() # 打开页面
    try:
        # 规避Webdriver检测
        js = """
        Object.defineProperties(navigator, {webdriver:{get:()=>undefined}});
        """
        page.add_init_script(js)
        login_url = "https://console.section.io"
        page.goto(login_url, timeout=45 * 1000)  # 打开section网页, 响应超时45s
        page.wait_for_load_state("load", timeout=20 * 1000)  # 等待页面加载,响应超时20s domcontentloaded, load, networkidle
        user_input = page.query_selector_all(user_name)
        if user_input:
            if page.query_selector_all(captcha):  # 检测验证码是否存在
                status = svg_code_input(page, user_name, usr, user_button)  # 验证码提前出现在输入账户处
                if status:
                    return
                page.fill(pass_word, pwd)  # 输入密码
                page.click(passwd_button)  # 点击密码提交
                page.wait_for_load_state("networkidle", timeout=20 * 1000)
            else:
                page.fill(user_name, usr)  # 输入账户
                page.click(user_button)  # 点击账户提交
                page.wait_for_load_state("networkidle", timeout=5 * 1000)
                if page.query_selector_all(captcha):
                    if page.query_selector_all(user_name):
                        status = svg_code_input(page, user_name, usr, user_button)  # 验证码延迟出现在输入账户
                        if status:
                            return
                    elif page.query_selector_all(pass_word):
                        status = svg_code_input(page, pass_word, pwd, passwd_button)  # 验证码出现在输入密码处
                        if status:
                            return
                else:
                    print("没有出现验证码")
                    page.fill(pass_word, pwd)  # 输入密码
                    page.click(passwd_button)  # 点击密码提交
                    page.wait_for_load_state("networkidle", timeout=20 * 1000)
            if page.query_selector_all(error_login):
                List.append("帐户在多次连续登录尝试后被阻止！结束页面！")
                return
            if page.query_selector_all(error_pwd):
                List.append("账号登陆失败: 账号或密码错误")
                return
        suc_login = page.wait_for_selector(email_name, timeout=40 * 1000)  # 等待主页面出现,响应超时40s
        if suc_login:
            print("账户登陆成功")
            api_url = "graphql_api/query"  # xhr路径
            page.on("response", lambda response: handle_response(response, api_url))  # 获取api响应体数据
            page.reload()
            page.wait_for_load_state("networkidle", timeout=20 * 1000)
            html = page.content()
            if "Welcome" in html or hd_resp_times == 1:
                List.append("账户未创建应用，不进行续期操作！")
            else:
                keep_alive(page)  # 续期操作
        else:
            print("无法获取页面信息！！！结束页面")
            return
    except Exception as err:
        List.append(f'行号：{err.__traceback__.tb_lineno}\n错误信息：{err}')
    finally:
        page.close()
        context.close()


def keep_alive(page):
    try:
        page.set_default_timeout(2000)  # 设置默认超时时间为2秒
        state = page.query_selector_all(active_state)  # 应用处于活跃状态无需续期
        state1 = page.query_selector_all(delay_time)  # 应用处于可续期状态
        state2 = page.query_selector_all(wake_dormant)  # 应用处于休眠状态
        if state:
            List.append("应用处于最新活动状态，无需续期！")
        elif state1:
            List.append("应用处于可续期状态，开始续期！")
            page.click(delay_time) # 点击延长续期
            page.wait_for_selector(pop_up)  # 等待弹窗出现
            page.click(renew_button)  # 点击延长
            check_status(page)
        elif state2:
            List.append("应用处于休眠状态，开始激活！")
            page.click(wake_dormant)
            page.wait_for_selector(pop_up)
            page.click(renew_button)
            check_status(page)
        else:
            List.append("应用状态未知，请排查元素！")
    except Exception as err:
        List.append(f'行号：{err.__traceback__.tb_lineno}\n错误信息：{err}')


def check_status(page):
    try:
        page.reload(timeout=40 * 1000)
        page.wait_for_load_state("networkidle", timeout=20 * 1000)
        if page.query_selector_all(active_state):
            List.append("应用续期成功！休眠时间已延后！")
        elif page.query_selector_all(delay_time):
            List.append("续期失败，当前应用仍处于可续期状态！")
        elif page.query_selector_all(wake_dormant):
            List.append("激活失败，当前应用仍处于休眠状态！")
        else:
            List.append("未能检测到应用状态！")
    except Exception as err:
        List.append(f'行号：{err.__traceback__.tb_lineno}\n错误信息：{err}')


def handle_response(response, api_url):
    global hd_resp_times  # 提取两次json数据
    if hd_resp_times < 2:
        if api_url in response.url and response.status == 200:
            json_data = response.json()
            if json_data.get("data", {}).get("getCurrentUser"):
                data_acount = json_data.get("data", {}).get("getCurrentUser")
                List.append(f'账户`{data_acount.get("first_name")} {data_acount.get("last_name")}`登陆成功\n账户id：{data_acount.get("accounts")[0].get("id")}\n注册日期：{data_acount.get("createdAt")}')
                hd_resp_times += 1
            if json_data.get("data", {}).get("account", {}).get("applications"):
                data_applications = json_data.get("data", {}).get("account", {}).get("applications")
                for item in range(len(data_applications)):
                    List.append(f'{data_applications[item].get("name")} 应用待休眠时间：{data_applications[item].get("hibernationExpirationDate")}')
                hd_resp_times += 1


if __name__ == "__main__":
    # delay_sec = random.randint(1, 50)
    # List.append(f'随机延时{delay_sec}s')
    # time.sleep(delay_sec)
    i = 0
    if 'SEC_TION' in os.environ:
        users = os.environ['SEC_TION'].split(';')
        with chrome_start() as browser:
            for x in users:
                i += 1
                name, pwd = x.split('-')
                List.append(f'===> [账号{str(i)}]Start <===')
                hd_resp_times = 0
                login(browser, name, pwd)
                List.append(f'===> [账号{str(i)}]End <===\n')
                time.sleep(1)
            browser.close()
        List = list(map(str, List))
        tt = '\n'.join(List)
        print(tt)
        send('section', tt)
    else:
        print('未配置环境变量')
        send('section', '未配置环境变量')
