resource "aws_ebs_volume" "ec2-ebs" {
 /* count             = "${var.ec2_count}" */
 /* availability_zone = "${var.availability_zone}" */
 /* kms_key_id        =  "xxxx"  */
  encrypted         =   "true"
 /* size              =   "${var.vol_size_details_xvdf}" */
/*  type              =   "${var.vol_type_details}" */
  tags {
    Name        =   "d-drive"
    Owner       =   "mcms"
    Managed_By  =   "Terraform"
  }
}
