# 🔐 Security Policy

## 🔑 Secrets Used in This Repo

### **1️⃣ `GH_TOKEN`**  
- This is a GitHub Actions secret used for automated releases via Release-Please.  
- It wraps `GITHUB_TOKEN`, which is managed by GitHub.  
- This secret **does not expire** unless deleted from repo settings.  

### **2️⃣ `DOCKER_USERNAME`**  
- This is the **Docker Hub access username** used for pushing container images.  
- It is the docker username i.e account name.  

### **3️⃣ `DOCKER_PASSWORD`**  
- This is the **Docker Hub access token** used for pushing images.  
- It should be generated from **Docker Hub → Account Settings → Security → New Access Token**.  
- **Scopes Required:** `write` access to Docker repositories.  
- **Where to add:** Go to **GitHub → Settings → Secrets → Actions**, create `DOCKER_PASSWORD`.  

## 🔍 How to Rotate Secrets  
If any secret expires or needs updating:  
1. Generate a new token from the respective service (**github.com** or **Docker Hub**).  
2. Update the secret in **GitHub → Settings → Secrets → Actions**.  
3. The next workflow run will automatically use the new credentials.  

## 🛠 Reporting Security Issues  
If you find a security vulnerability in this repo, please [open a security advisory](https://github.com/samordil/practice/security/advisories).
