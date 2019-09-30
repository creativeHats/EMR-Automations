#!/usr/bin/env bash

aws --region=us-east-1 emr create-cluster \
--release-label "emr-5.27.0" \
--name "Data Pipeline" \
--log-uri "s3n://<>/logs/" \
--ec2-attributes KeyName=spark-livy,InstanceProfile=EMR_EC2_DefaultRole,EmrManagedMasterSecurityGroup=<>,EmrManagedSlaveSecurityGroup=<>,SubnetId=<>,AdditionalMasterSecurityGroups=[<>],AdditionalSlaveSecurityGroups=[<>] \
--no-termination-protected \
--visible-to-all-users \
--enable-debugging \
--tags "project=myproject" \
--applications Name=Spark Name=Hadoop Name=Livy Name=Livy Name=Ganglia \
--no-auto-terminate \
--service-role "EMR_DefaultRole" \
--bootstrap-actions Path="s3://<>/launchEMRBootStrap.sh" \
--instance-groups 'InstanceGroupType=MASTER,InstanceCount=1,InstanceType=m4.large'\
 'InstanceGroupType=CORE,InstanceCount=2,InstanceType=m4.4xlarge, EbsConfiguration={EbsOptimized=true, EbsBlockDeviceConfigs=[{VolumeSpecification={VolumeType=gp2, SizeInGB=256}, VolumesPerInstance=2}]}' \
 'InstanceGroupType=TASK,InstanceType=m4.4xlarge,InstanceCount=2, EbsConfiguration={EbsOptimized=true, EbsBlockDeviceConfigs=[{VolumeSpecification={VolumeType=gp2, SizeInGB=256}, VolumesPerInstance=2}]}' \
 --configurations '[{
                      "Classification":"spark-log4j",
                            "Properties":{"log4j.rootCategory":"ERROR, console"}
                    },
			                 {
                      "Classification": "yarn-site",
                      "Properties": {
                        "yarn.nodemanager.vmem-check-enabled": "false",
                        "yarn.nodemanager.pmem-check-enabled": "false"
                      }
                    },
                    {
                      "Classification": "spark",
                      "Properties": {
                        "maximizeResourceAllocation": "false"
                      }
                    },
                    {
                      "Classification": "spark-defaults",
                      "Properties": {
                        "spark.network.timeout": "800s",
                        "spark.executor.heartbeatInterval": "60s",
                        "spark.dynamicAllocation.enabled": "false",
                        "spark.driver.memory": "12000M",
                        "spark.executor.memory": "12000M",
                        "spark.executor.cores": "7",
			            "spark.executor.instances": "18",
                        "spark.yarn.executor.memoryOverhead": "4000M",
                        "spark.yarn.driver.memoryOverhead": "4000M",
                        "spark.memory.fraction": "0.80",
                        "spark.memory.storageFraction": "0.30",
                        "spark.yarn.scheduler.reporterThread.maxFailures": "5",
                        "spark.storage.level": "MEMORY_AND_DISK_SER",
                        "spark.rdd.compress": "true",
                        "spark.shuffle.compress": "true",
                        "spark.shuffle.spill.compress": "true",
                        "spark.default.parallelism": "800"
                      }
                    },
                    {
                      "Classification": "mapred-site",
                      "Properties": {
                        "mapreduce.map.output.compress": "true"
                      }}]'
