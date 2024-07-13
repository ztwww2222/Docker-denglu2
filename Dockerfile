# Use the official Python image
FROM daxia2023/do:plfirefox

# Set environment variables
ENV PORT=7860

# Expose the specified port
EXPOSE ${PORT}

# Set the working directory
WORKDIR /app

# Copy only necessary files
COPY entrypoint.sh .
COPY nginx.conf .
COPY web/ ./web
COPY sendNotify.py .
COPY baohuo.py .
COPY baohuo2.py .
COPY section.py .
COPY koyeb.py .
COPY streamlit.py .

# Install system dependencies and clean up
RUN apt-get update && \
    apt-get install -y \
    nginx \
    git && \
    pip install requests && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    chmod a+x ./entrypoint.sh ./web/nez
    

# Run the script
CMD ["/app/entrypoint.sh"]


