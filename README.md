alpine-vault
===============

This image permit to run Vault.



### Parameters

#### Confd

The Minio setting is managed by Confd. So you can custom it:
- **CONFD_BACKEND**: The Confd backend that you should use. Default is `env`.
- **CONFD_NODES**: The array of Confd URL to contact the backend. No default value.
- **CONFD_PREFIX_KEY**: The Confd prefix key. Default is `/vault`


#### Vault

Main parameters:
- **VAULT_CONFIG_DEFAULTLEASETTL**: The default lease ttl use when generate token
- **VAULT_CONFIG_MAXLEASETTL**: The maximum lease ttl use when generate token
- **VAULT_CONFIG_STORAGE**: File or Consul

Consul parameters:
- **VAULT_CONFIG_CONSUL_ADDRESS**: The consul address server
- **VAULT_CONFIG_CONSUL_SCHEME**: The sheme to use to communicate with consul. Default to `http`.
- **VAULT_CONFIG_CONSUL_TOKEN**: The vault token to communicate with Consul.
- **VAULT_CONFIG_CONSUL_PATH**: The path to use in consul to store data. Default to `vault`.
