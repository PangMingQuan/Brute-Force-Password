#!/bin/bash
set –f
set +H
# LIST is the list of characters to try
LIST="Q W E R T Y U I O P A S D F G H J K L Z X C V B N M"
LIST1="0 1 2 3 4 5 6 7 8 9"
LIST2="a b c d e f g h i j k l m n o p q r s t u v w x y z"
LIST3="~ @ # $ % ^ * _ + - = { } [ ] ? ; : "
LIST4="~ @ # $ % ^ * _ + - = { } [ ] ? ; : "
Echo “Choose from b08 to b14”
read num
encr=`grep $num hackcode.txt | cut –c 7-17`
salt=`grep $num hackcode.txt | cut –c 5-6`
for i in $LIST
  do
   for j in $LIST1
    do
      for k in $LIST2
       do
         for l in $LIST3
          do
	   for m in $LIST4
	     do
	       echo -n "$i$j$k$l$m "	
#DES is used to generate hash values
#mkpasswd used to encrypted the password using a password and a salt
#now we try to encrypt every 5 combination of password to compare to the
#encrypted password that retrieve by encr   

  test=`mkpasswd -m des "$i$j$k$l$m" -s $salt | cut –c 3-13`
		if [ $test == $encr ] ; then
		echo "Password is: "$i$j$k$l$m""
                             echo “Salt is: “$salt””
                             echo “Hash is: “$encr””
		exit
                              fi
	done
      done
    done
  done
done
