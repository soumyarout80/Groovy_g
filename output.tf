/*
output "instance_ips" {
  value = ["${aws_instance.Node.*.public_ip}"]
}
output "Forwarder_ip" {
  value = "${join(",", aws_instance.Node.*.public_ip)}"
}
output "source_Aggregater_ip" {
  value = "${join(",", aws_instance.Node1.*.public_ip)}"
}
output "Destination_ip" {
  value = "${join(",", aws_instance.Node2.*.public_ip)}"
}

output "Forwarder_tag" {
  value = "${aws_instance.Node.*.tags.Name}"
}
output "source_tag" {
  value = "${aws_instance.Node1.*.tags.Name}"
}
output "Destination_tag" {
  value = "${aws_instance.Node2.*.tags.Name}"
}
*/

output "Elasticsearch_Kibana_tag" {
  value = "${aws_instance.ek.*.tags.Name}"
}
output "Elasticsearch_Kibana_ip" {
  value = "${aws_instance.ek.*.public_ip}"
}

output "Forwarder_tag" {
  value = "${aws_instance.Node.*.tags.Name}"
}
output "Forwarder_ip" {
  value = "${aws_instance.Node.*.public_ip}"
}

output "Destination_tag" {
  value = "${aws_instance.Node2.*.tags.Name}"
}
output "Destination_ip" {
  value = "${aws_instance.Node2.*.public_ip}"
}
output "source_tag" {
  value = "${aws_instance.Node1.*.tags.Name}"
}
output "source_Aggregater_ip" {
  value = "${aws_instance.Node1.*.public_ip}"
}
/*
output "forwarder_detail" {
  value = "${concat(aws_instance.Node.*.tags.Name, aws_instance.Node.*.public_ip)}"
}

output "source_aggregater" {
  value = "${concat(aws_instance.Node1.*.tags.Name, aws_instance.Node1.*.public_ip )}"
}

output "destination_aggregater" {
  value = "${concat(aws_instance.Node2.*.tags.Name,  aws_instance.Node2.*.public_ip )}"
}*/
