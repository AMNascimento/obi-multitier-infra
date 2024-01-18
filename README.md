# obi-multitier-infra

## MultiTier Web Application with Terraform

### Objective:

Design and implement a secure, scalable, and highly available multi-tier web application using Terraform. The application should consist of a front-end, a back-end API, and a database layer.

### Requirements:

Cloud Provider: Use any major cloud provider like AWS, Azure, or GCP. Clearly document the choice and reasons.

Infrastructure as Code: Use Terraform to script the entire infrastructure. The code should be modular, reusable, and well-documented.

#### Front-End:

- Deploy a scalable and load-balanced web server cluster.
- Implement auto-scaling based on traffic.
- Ensure the deployment is done in a private subnet (if applicable).

#### Back-End API:

- Deploy a set of API servers, ensuring high availability.
- Secure communication between the front-end and API servers.
- Implement rate limiting and health checks.

#### Database:

- Use a managed database service (e.g., RDS, Cloud SQL).
- Ensure database is in a private subnet and not publicly accessible.
- Implement read replicas and automatic failover.

#### Networking:

- Configure all necessary VPCs, subnets, NAT gateways, and route tables.
- Implement strict firewall rules to ensure security.

#### Security:

- Use IAM roles and policies for access control.
- Encrypt data in transit and at rest.
- Implement logging and monitoring for all resources.

#### Documentation:

- Provide a README.md file explaining the architecture, how to deploy the infrastructure, and any assumptions made.
- Include diagrams where necessary.

#### Bonus Points:

- Implement infrastructure monitoring and alerts.
- Add a CI/CD pipeline for the infrastructure code.
- Write unit tests for Terraform configurations.

#### Evaluation Criteria:

- Code Quality: Is the Terraform code well-structured, efficient, and maintainable?
- Security: How well are security practices integrated?
- Scalability and High Availability: Does the infrastructure support scaling and resilience?
- Documentation: Is the documentation clear and comprehensive?
- Innovation: Any additional features or creative solutions.
