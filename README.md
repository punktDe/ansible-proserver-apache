# apache-prosever-apache
An Ansible role that sets up Apache on a Proserver. 

### Configuration
| Variable name | Default value | Example value |Description |
| ------------- | ------------- | ------------- |----------- |
| `apache.redirects` | {} | {'http://source-url.punkt.dev': 'https://target-url.punkt.dev'} | Dictionary of URLs to be redirected |
| `apache.htpasswd` | {} | {'user': 'password'} | Dictionary of credentials to be made available for Apache vhosts |
