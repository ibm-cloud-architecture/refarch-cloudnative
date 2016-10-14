# BlueCompute Security Architecture

Security is critical for developing and hosting the BlueCompute application on IBM Cloud. In R1 release, we have implemented several key security features:  

- Authentication (Mocked and LDAP)
- Authorization (OAuth2.0)
- Transportation Security with HTTPs
- Network isolation
- Intra-component auth via JWT Token

The overall security diagram is shown below (security flow is labeled with red text):  
![Security Overview](imgs/OmniChannelEndToEnd_security.png?raw=true)  


## Security flow

BlueCompute workload typically has the following security flow:
Client(mobile/web) *HTTPs/OAuth*-> API Connect -> *HTTPs/JWT*->  Node BFF *HTTPs*-> Bluemix GoRouter *HTTPs/JWT*-> Zuul *HTTP/Private Network*-> Microservices containers

- Mobile client and Web application accesses APIs hosted by IBM API Connect over HTTPs
- Mobile and Web client authenticates against the authentication service or LDAP (redirected by APIC)
- Mobile and Web client grant access to resources via OAuth 2.0 where APIC is the OAuth Provider
- API Connect generates JWT (JSON Web Token) to access the downstream Zuul proxy
- API Connect invokes BFF node.js application over HTTPs with Mutual TLS authentication
- Node.js app pass-thru the JWT token and invoke Zuul proxy over HTTPs
- Zuul proxy validates the JWT Token to allow access only to APIC initiated workload
- Zuul invokes the data access microservices over Bluemix private network (Container Service)
