安装脚本

登陆linux服务器使用官方一键安装脚本安装acme.sh

wget -O - https://get.acme.sh | sh

配置自动API

cd /root/.acme.sh && nano account.conf

CF示例：
export CF_Token="PfCA6tyLxxxxxxxx-sS6ANgqzuVexxxxxxx"
export CF_Account_ID="1fs48ec7e2063cb70hacc3xxxxxxxxxx"

DNSPOD示例：
export DP_Id="124xxx"
export DP_Key="54ddaa41245837600ce713xxxxxxxxxx"

自动DNS申请模式：
acme.sh --issue --server letsencrypt --dns dns_dp -d example.com
上方是dnspod，使用cf请红色位置改为cf

证书类型可选，选择zerossl第一次使用是需要加上-m XXX@XX.XX注册邮箱做为帐号

结合cron可自动更新证书。
之前是因为肥牛香菇的CDN每次都是要手动续期，所以使用acme自动续期证书，再结合crontab 定时cp覆盖，可免手动。
