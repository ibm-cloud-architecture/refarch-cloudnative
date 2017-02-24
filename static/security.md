# BlueCompute Security Architecture

Security is critical for developing and hosting the BlueCompute application on IBM Cloud. In R3 release, we have implemented several key security features:  

- Authentication (against Customer Microservice)
- Authorization (OAuth2.0)
- Transportation Security with HTTPs
- Network isolation
- Intra-component auth via JWT Token

The overall security diagram is shown below (security flow is labeled with red text):  
![Security Overview](imgs/OmniChannelEndToEnd_security.png?raw=true)  


## Security flow

BlueCompute workload typically has the following security flow:
Client(mobile/web) *HTTPs/OAuth*-> API Connect -> *HTTPs/JWT* -> Bluemix GoRouter *HTTPs/JWT* -> Zuul *HTTP/Private Network*-> Microservices containers

- Mobile client and Web application accesses APIs hosted by IBM API Connect over HTTPs
- Mobile and Web client authenticates against the authentication service (redirected by APIC)
  - The authentication service communicates with the Customer Microservice over the private container network
- Mobile and Web client grant access to resources via OAuth 2.0 where APIC is the OAuth Provider
- API Connect generates JWT (JSON Web Token) to access the downstream Zuul proxy
- API Connect invokes Zuul proxy over HTTPs
- Zuul proxy validates the JWT Token to allow access only to APIC initiated workload
- Zuul invokes the data access microservices over Bluemix private network (Container Service)

All BlueCompute components communicating with BlueMix services (i.e. Cloudant, ElasticSearch, or MessageHub) outside of the Container Network do so through the NAT gateway.  All outbound connections are encrypted TLS connections.

## Generate JWT Shared key

BlueCompute JWT implementation uses HS256 algorithm to sign and verify the JWT token. You need to have a JWK key for both the API Connect gateway and the Zuul proxy. You can get a key using the online JWK generate at [https://mkjwk.org/](https://mkjwk.org/).

At the site, select **Shared Secret** tab at the key generation form,
Keep the default key size (2048), Select **Signing** for Key use and **HS256** for Algorithm. Keep the Key ID field empty, then click "Generate new key" button, you should get your key as following:

![JWT Key generator](imgs/jwk_key_generator.png?raw=true) 

Under the **"Key"** section, locate the field for **k:**, that's your shared key. You need to provide it to your APIs and Zuul proxy application configuration file.
