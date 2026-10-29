# EC2 Instances
  - Launch an EC2 instance
  - After launching an EC2 instance, if you don't want to use it, you should stop it because it will cost you money.
  - If you stop an EC2 instance, you can start it again.
  - Public IP address will be changed after you stop and start the EC2 instance. But not the Private IP address.


# Security Groups
  - Security Groups are used to control the traffic that is allowed to enter or leave an EC2 instance.
  - Security Groups are stateless. They are not associated with any EC2 instance.
  - Security Groups are the fundamental of network security in AWS.
  - They control how traffic is allowed into or out of an EC2 instance.
  - Security Groups only contain "allow" rules.
  - Security Groups rules can reference by IP or by security group.

  - create security group             
    - aws ec2 create-security-group --group-name my-security-group --description "My security group"


  - delete security group
    - aws ec2 delete-security-group --group-name my-security-group

  - add a rule to a security group
    - aws ec2 authorize-security-group-ingress --group-name my-security-group --protocol tcp --port 22 --cidr 0.0.0.0/0


- Security Groups are acting as a firewall on the EC2 instance.
- They regulate
   - Access to Ports
   - Authorised IP ranges - IPv4 and IPv6
   - Control of inbound network traffic (from other(internet) to the EC2 instance)
   - Control of outbound network traffic (from the EC2 instance to the Internet)


- Can be attached to multiple instances
- Locked down to a region/VPC combination
- Does live "outside" the EC2 - if traffic is blocked the EC2 instance won't see it
- it's good to maintain one separate security group for SSH access
- if your application is not accessible (timeout), then it's a security group issue
- if your application gives a "connection refused" error, then it's an application error or it's not launched
- All inbound traffic is blocked by default
- All outbound traffic is allowed by default (authorised)

# Classic Ports to know
- 22 = SSH (Secure Shell) - Log into a Linux instance
- 21 = FTP - File Transfer Protocol - upload files into a file share
- 22 = SFTP - Secure File Transfer Protocol - upload files using SSH
- 80 = HTTP - access unsecured websites
- 443 = HTTPS - access secured websites
- 3389 = RDP - Remote Desktop Protocol - log into a Windows instance


# SSH Summary Table

# How to terminate Spot Instances?
- Maximum price
- Desired number of instances
- Launch specification
- Request type: one-time | persistent
- Valid from, Valid until 


# Spot Fleets
- Spot Fleets = set of Spot Instances + (optional) On-Demand Instances
- The Spot Fleet will try to meet the target capacity with price constraints
  - Define possible launch pools: instance type (m5.large), OS, Availability Zone
  - Can have multiple launch pools, so that the fleet can choose the best instance type
  - Can have a maximum of 10 launch pools
  - Spot Fleet stops launching instances when reaching capacity or max cost.
- Strategies to allocate Spot Instances
  - lowestPrice: from the pool with the lowest price (cost optimization, short workload)
  - diversified: distributed across all pools (great for availability, long workloads)
  - capacityOptimized: pool with the optimal capacity for the number of instances
  - priceCapacityOptimized(recommended): pools with highest capacity available, then select the pool with the lowest price (best choice for most workloads)
- Spot Fleets allow us to automatically request Spot Instances with the lowest price

# Private vs Public IP (IPv4)

- Networking has two sorts of IPs.IPv4 and IPv6
  - IPv4: 1.160.0.240
  - IPv6: 2600:1f18:100:2000:0:ffff:fe00:1

- IPv4 is still the most common format used online
- IPv6 is newer and solves problems for the Internet of Things (IoT)

-IPv4 allows for 3.7 billion different addresses in the public space

# Public IP
- Public IP means the machine can be identified on the internet (www)
- Must be unique across the whole web (not two machines can have the same public IP)
- Can be geo-located easily (US, EU, Asia, Australia, etc)

# Private IP
- Private IP means the machine can only be identified on a private network only
- The IP must be unique across the private network
- But two different private networks(two companies) can have the same private IPs
- Machines connect to www using an internet gateway (a proxy)
- Only a specified range of IPs can be used as private IP

# Elastic IP
- When you stop and then start an EC2 instance, it can change its public IP address
- If you need to have a fixed public IP for your instance, you need an Elastic IP
- An Elastic IP is a public IPv4 IP you own as long as you don't delete it
- You can attach it to one instance at a time


- With an Elastic IP, you can mask the failure of an instance or software by rapidly remapping the address to another instance in your account.
- You can only have 5 Elastic IP in your account ( you can ask AWS to increase that)

- Overall, try to avoid using Elastic IPs:
  - They often reflect poor architectural decisions
  - Instead, use a random public IP and register a DNS name to it
  - Or, as we'll see later, use a Load Balancer and don't use a public IP

In AWS EC2 - Hands On

- By default, your EC2 machine comes with:
  - A private IP for the internal AWS Network
  - A public IP, for the www

- When we are doing SSH into our EC2 machines:
  - We can't use a private IP, because we are not in the same network

- If your machine is stopped and then started, the public IP will change


# Elastic IP ကို မသုံးသင့်သည့် အကြောင်းအရင်းများ (Why NOT to use)
- Architecture Scaling အတွက် အဆင်မပြေခြင်း (Anti-pattern for Auto Scaling):

- Elastic IP သည် instance တစ်ခုတည်းသို့သာ တိုက်ရိုက်ချိတ်ဆက်နိုင်သည်။ Auto Scaling Group တွင် instance အသစ်များ အလိုအလျောက် တိုးလာ/လျော့သွားသည့်အခါ EIP ဖြင့် ချိတ်ဆက်၍ မရပါ။ ယင်းအစား Application Load Balancer (ALB) သို့မဟုတ် Route 53 DNS ကို အသုံးပြုခြင်းက ပိုမိုသင့်လျော်သည်။

# ကုန်ကျစရိတ် (Cost & Waste):

- AWS တွင် EIP များကို အသုံးမပြုဘဲ ထားရှိပါက (instance တစ်ခုနှင့် တွဲမထားလျှင် သို့မဟုတ် တွဲထားသည့် instance က ရပ်တန့်နေလျှင်) public IPv4 ရှားပါးမှုကြောင့် hourly fee ကောက်ခံပါသည်။ ထို့အပြင် AWS သည် ပုံမှန်တွဲထားသည့် EIP များအပါအဝင် public IPv4 address တိုင်းအတွက် တစ်နာရီလျှင် standard rate ($0.005/hr ဝန်းကျင်) စတင်ကောက်ခံသောကြောင့် မလိုအပ်ဘဲ EIP အများအပြား ယူထားပါက ကုန်ကျစရိတ် တက်လာနိုင်သည်။

# Single Point of Failure (SPOF) ဖြစ်နိုင်ခြေ:

- စနစ်တစ်ခုလုံးကို EIP တစ်ခုတည်း သို့မဟုတ် EC2 instance တစ်ခုတည်း၏ public IP ပေါ် မှီခိုစေခြင်းသည် High Availability (HA) မရရှိစေဘဲ server ပျက်ကျပါက downtime ဖြစ်စေနိုင်သည်။

# Service Quotas (ကန့်သတ်ချက်များ):

- AWS account တစ်ခုလျှင် Region တစ်ခုအတွက် default အားဖြင့် EIP ၅ ခုသာ ခွင့်ပြုထားသောကြောင့် instance တိုင်းအတွက် EIP သုံးရန် မဖြစ်နိုင်ပါ။

- Elastic IP ကို သုံးသင့်သည့် အကြောင်းအရင်းများ (When & Why to use)
IP Whitelisting / Firewall Rules လိုအပ်ခြင်း:

- ပြင်ပ Third-party API များ၊ ငွေပေးချေမှုစနစ်များ (Payment Gateways) သို့မဟုတ် On-premises corporate firewall များက သင့်ဆီကလာသော IP ကိုသာ ခွင့်ပြုမည်ဟု သတ်မှတ်ထားသောအခါ ပုံသေ outbound/inbound IP လိုအပ်သဖြင့် EIP ကို သုံးသင့်သည်။

# NAT Gateway များအတွက် မဖြစ်မနေလိုအပ်ခြင်း:

- Private Subnet ရှိ server များ အင်တာနက်အသုံးပြုနိုင်ရန် (outbound internet access) VPC NAT Gateway တည်ဆောက်သည့်အခါ AWS က Elastic IP တစ်ခု မဖြစ်မနေ တွဲပေးရန် လိုအပ်သည်။

# DNS Propagation မစောင့်လိုဘဲ Failover ပြုလုပ်လိုခြင်း:

- Server တစ်ခု ပျက်ကျသွားပါက backup server အသစ်တစ်ခုဆီသို့ IP address ကို စက္ကန့်ပိုင်းအတွင်း ချက်ချင်း လွှဲပြောင်း (re-map) ပေးနိုင်သောကြောင့် DNS cache update ဖြစ်ရန် စောင့်စရာမလိုဘဲ လျင်မြန်စွာ recovery လုပ်နိုင်သည်။

# Single-instance Workloads (ပုံသေ public IP လိုအပ်သော standalone server များ):

- Load Balancer အသုံးမပြုထားသော ရိုးရှင်းသည့် server တစ်ခု (ဥပမာ- internal tool, SFTP server, demo environment) ကို stop/start ပြုလုပ်သည့်အခါ IP မပြောင်းသွားစေရန် EIP ချိတ်ထားသင့်သည်။

# အချုပ်အားဖြင့်ဆိုရသော် Web Application များနှင့် dynamic microservices များအတွက် Load Balancer + Route 53 ပေါင်းစပ်မှုကိုသာ အဓိက သုံးသင့်ပြီး၊ NAT Gateway များနှင့် Fixed-IP Whitelisting လိုအပ်ချက်များအတွက်သာ Elastic IP ကို ရွေးချယ်အသုံးပြုသင့်သည်။

# Placement Groups
- Network အမြန်နှုန်းနှင့် Latency အနည်းဆုံးရရှိရန် အတွက် Cluster ကို သုံးပြီး၊ Hardware ပျက်စီးမှုဒဏ်မှ အပြည့်အဝ ကာကွယ်ရန် အတွက် Spread သို့မဟုတ် Partition ကို အသုံးပြုကြခြင်း ဖြစ်သည်။

# Elastic Network Interfaces (ENI)
- Logical component in a VPc that represents a virtual network card
- The ENI can have the following attributes:
  - Primary private IPv4, one or more secondary IPv4
  - One Elastic IP (IPv4) per private IPv4
  - One Public IPv4
  - One or more security groups
  - A MAC address

- You can create ENI independently and attach them on the fly (move them) on EC2 instances for failouver
- Bound to a specific availability zone(AZ)


# AWS EC2 တွင် Snapshot (အထူးသဖြင့် EBS Snapshot) ဆိုသည်မှာ EC2 instance နှင့် တွဲဖက်အသုံးပြုထားသော Elastic Block Store (EBS) volume များ၏ သတ်မှတ်ထားသော အချိန်ကာလတစ်ခုအတွင်းရှိ ဒေတာအခြေအနေကို point-in-time backup အဖြစ် သိမ်းဆည်းပေးသည့် နည်းပညာတစ်ခု ဖြစ်သည်။

၎င်း snapshot ဒေတာများကို AWS မှ Amazon S3 ပေါ်တွင် အလိုအလျောက် သီးခြား redundancy မြင့်မားစွာ သိမ်းဆည်းပေးပါသည်။

၁။ Snapshot ကို အဓိက အသုံးပြုရသည့် ရည်ရွယ်ချက်များ
Data Backup နှင့် Disaster Recovery (DR):

စနစ်တစ်ခုလုံး သို့မဟုတ် Volume ပျက်စီးသွားခြင်း၊ လူအမှားကြောင့် Data များ delete/corrupt ဖြစ်သွားခြင်းများ ကြုံတွေ့ရပါက ယခင် snapshot မှတစ်ဆင့် Volume အသစ်တစ်ခုအဖြစ် မူလအတိုင်း ပြန်လည် recover ပြုလုပ်နိုင်သည်။

# Server/Volume Clone ပြုလုပ်ခြင်း နှင့် Scaling:

လက်ရှိ Run နေသော instance ၏ snapshot မှတစ်ဆင့် Amazon Machine Image (AMI) ပြုလုပ်ပြီး ထို image ဖြင့် server အသစ်များ (ဥပမာ- Auto Scaling Group များအတွက်) အလွယ်တကူ ပွားယူနိုင်သည်။

Volume Size သို့မဟုတ် Type ပြောင်းလဲခြင်း (Resizing / Migration):

Volume အရွယ်အစားကို ပိုကြီးအောင် ပြုလုပ်လိုလျှင် သို့မဟုတ် Volume type ကို ပြောင်းလိုပါက (ဥပမာ- gp2 မှ ပိုမိုမြန်ဆန်သော gp3 သို့မဟုတ် io2 သို့ ပြောင်းလဲခြင်း) snapshot ယူပြီး အသစ်ပြန် create ပြုလုပ်နိုင်သည်။

# Cross-Region သို့မဟုတ် Cross-AZ Migration:

EBS volume တစ်ခုသည် တည်ဆောက်ထားသော Availability Zone (AZ) တစ်ခုတည်းတွင်သာ အလုပ်လုပ်သည်။ သို့သော် snapshot ယူထားပါက အခြားသော AZ သို့မဟုတ် အခြား Region တစ်ခုဆီသို့ snapshot ကို copy ကူးပြောင်းပြီး ထိုနေရာတွင် Volume/Instance အသစ်အဖြစ် ပြန်လည် အသုံးပြုနိုင်သည်။

Environment များ ခွဲထုတ်ခြင်း (Dev / Staging / Production):

Production server ရှိ လက်ရှိ ဒေတာများကို Snapshot ယူကာ Staging သို့မဟုတ် Testing environment များဆီသို့ ပို့ဆောင်ပြီး စမ်းသပ်စစ်ဆေးမှုများ ပြုလုပ်နိုင်သည်။

# ၂။ Snapshot ၏ အရေးကြီးသော လုပ်ဆောင်ချက် သဘောတရားများ
Incremental Backup စနစ်:

Snapshot များသည် ပထမဆုံးအကြိမ်တွင် Volume ရှိ Data အပြည့်အစုံကို သိမ်းဆည်းသော်လည်း၊ နောက်ပိုင်းယူသော snapshot များတွင် ယခင် snapshot နှင့် မတူတော့ဘဲ အသစ်ပြောင်းလဲသွားသော data blocks (delta) များကိုသာ သိမ်းဆည်းသည်။ ထို့ကြောင့် Storage ကုန်ကျစရိတ်ကို အများအပြား သက်သာစေပါသည်။

# S3 ပေါ်တွင် လုံခြုံစွာ တည်ရှိခြင်း:

Snapshot များကို User ၏ S3 bucket ထဲတွင် တိုက်ရိုက် မမြင်ရသော်လည်း AWS managed S3 infrastructure ပေါ်တွင် 11 9s (99.999999999%) durability ဖြင့် သိမ်းဆည်းပေးထားသည်။

KMS Encryption အထောက်အပံ့:

EBS volume သည် encrypted ဖြစ်နေပါက ၎င်းမှရရှိသော snapshot သည်လည်း အလိုအလျောက် encrypt ဖြစ်ပြီး၊ snapshot မှတစ်ဆင့် volume အသစ်ပြန်ဆောက်သည့်အခါ KMS key များကို အသုံးပြု၍ လုံခြုံစွာ ပြန်လည်ဖြည်နိုင်သည်။

# ၃။ အကောင်းဆုံး အလေ့အကျင့်များ (Best Practices)
Consistent Snapshot ရရှိစေရန် Instance ကို ခေတ္တရပ်ခြင်း (သို့မဟုတ်) Flush ပြုလုပ်ခြင်း:

Instance run နေစဉ် snapshot ယူနိုင်သော်လည်း (Crash-consistent)၊ database များကဲ့သို့ memory ပေါ်တွင် data ယာယီတင်ထားသော system များအတွက် I/O ကို pause လုပ်ခြင်း သို့မဟုတ် instance ကို stop ပြီးမှ snapshot ယူခြင်းက Data consistency အတွက် ပိုမိုစိတ်ချရသည်။

Amazon Data Lifecycle Manager (DLM) သုံးစွဲခြင်း:

Snapshot များကို နေ့စဉ်/အပတ်စဉ် အလိုအလျောက် schedule ဖြင့် ယူစေရန်နှင့် သတ်မှတ်ရက်ကျော်ပါက auto-delete လုပ်စေရန် AWS DLM သို့မဟုတ် AWS Backup ဖြင့် မူဝါဒ (Policy) ချမှတ်၍ စီမံသင့်သည်။

# Session 8: High Availability and Scalability ELb & ASG

# High Availability & Scalability For EC2

- Vertical Scaling: Increase instance size(= scale up/down)
  - From:t2.nano - 0.5G of RAM, I vCPU
  - To: u- 12tbI.metal - 12.3TB of RAM, 448 vCPUs

- Horizontal Scaling: Add more instances(= scale out/in)
  - Auto Scaling Group 
  - Load Balancer

- High Availability: Run instances for the same application across multiple AZs
  - Auto Scaling Group multiple AZs
  - Load Balancer multiple AZs


# Amazon Aurora

- Aurora is a proprietary technology from AWS (not open source)
- Aurora is a MySQL-compatible relational database
- Postgres and MySQL are both supported as Aurora DB (that means your drivers will work as if Aurora was Postgres or MySQL)
- Aurora is "AWS cloud optimized" and claims 5x performance improvement over MySQL on RDS, over 3x the performance of Postgres on RDS
- Aurora storage automatically grows in increments of 10GB, up to 256TB
- Aurora can have up to 15 replicas and the replication process is faster than MySQL (sub 10ms replica lag)
- Failover in Aurora instantaneous. It's High Availability(HA) native.
- Aurora costs more than RDS (20% more) -  but is more efficient

Aurora High Availability and Read Scaling
- 6 copies of your data across 3 AZs:
  - 4 copies out of 6 needed for writes
  - 3 copies out of 6 needed for reads
  - Self healing with peer-to-peer replication
  - Storage is striped across 100s of volumes

- One Aurora Instance takes writes (master)
- Automated failover for master in less than 30 seconds
- Master + up to 15 Aurora Read Replicas serve reads
- Support for Cross Region Replication (CRR)

# Feature of Aurora

- Automatic failover
- Backup and Recovery
- Isolation and security
- Scalability
- Industry compliance
- Push-button scaling
- Automated Patching with Zero Downtime
- Advanced Monitoring
- Routine Maintenance
- Backtrack: restore data at any point of time without using backups


