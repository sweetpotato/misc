function z(x){return x?x:0}
{a[$1]=1;c[$1]+=$2;if($2){t[$1]++}else{f[$1]++}}
END{for(i in a){print i,z(t[i]),z(f[i]),z(c[i])}}
