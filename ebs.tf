resource "aws_ebs_volume" "ec2-ebs" {
 /* count             = "${var.ec2_count}" */
    availability_zone = "eu-west-2a" 
 /* kms_key_id        =  "xxxx"  */
  encrypted         =   "true"
  size              =   "10g" */
/*  type              =   "${var.vol_type_details}" */
  
}
