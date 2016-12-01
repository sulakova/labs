- Click on **New** => **Compute** => **Azure Container Service**  => **Create** and Enter desired *User name*, and other details.
Use *Swarm* as an **Orchestrator configuration**. Choose *2* as **Agent Count** and enter unique **DNS prefix for container service**. Click **Ok** , **OK** and **Purchase**.

- Navigate to newly created resource group, choose **swarm-master-ip** Public IP address resource, use it's **DNS name**and ssh to connect to Swarm Master. Execute following code:
```
export DOCKER_HOST=:2375
docker info
docker  run -p 8080:8080 -p 50000:50000 jenkins
docker run -d -p 8080:80 yeasy/simple-web
docker ps
```
- Navigate to **swarm-agent-ip** Public IP address resource and open its DNS name with port 8080 in browser



