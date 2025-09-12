## The process to setup Grafana datasource connector to ecosystem server

1. Use the JSON API source
2. Assign url for login http://<server>>:3001/api/auth/login
3. Sign into swagger of the ecosystem server and generate a jwt token <key>
4. Setup a custom header with Authorization and Value of Bearer <key> 
