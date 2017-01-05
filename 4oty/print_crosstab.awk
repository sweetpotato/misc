function z(x){return x?x:0}
{m[$2,$3]=$1}
END{
	OFS="\t";
	print "cont","new";
	print "",0,1,2,3,4,5;
	for(i=0;i<=5;i++){
		print i,z(m[0,i]),z(m[1,i]),z(m[2,i]),
		        z(m[3,i]),z(m[4,i]),z(m[5,i]);
	}
}
