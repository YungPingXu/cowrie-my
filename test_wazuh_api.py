import requests
from requests.auth import HTTPBasicAuth

provider_ip = '192.168.122.1'
provider_port = 55000
vm_ip = '192.168.4.58'

req = requests.get(f'https://{provider_ip}:{provider_port}/security/user/authenticate?raw=true', auth=HTTPBasicAuth('wazuh', 'msggdZOFe7.WebyLtC5rCRkduSc2?98p'), verify=False)
token = req.text
print(token)

req = requests.get(f'https://{provider_ip}:{provider_port}/agents?select=id&ip={vm_ip}', headers={'Authorization': f'Bearer {token}'}, verify=False)
print(req.text)
