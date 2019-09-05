defmodule Use do
    def foo(0,the_node) do
    end
    def foo(count,the_node) do
        if count>0 do
                GenServer.call(String.to_atom(Use.sha_1(the_node)),:doit)
        end
        foo(count-1,the_node)
    end
    def fingggg(needed_node,r,node,hops) do
        #IO.inspect hops
        #IO.puts "jhghffghggggggggggggggggggggggggggggggggggggggggg #{hops}"
        GenServer.call(String.to_atom(Use.sha_1(needed_node)),{:gotoit,node,r,hops})
    end
   def findfingertable(node,up_node,r,fing,yo,hops) do
        len=Enum.count(fing)
        i=0
        newhop=if Enum.member?(fing,r)== true do
            hops+1
            #GenServer.cast(String.to_atom(Use.sha_1(node)),:update)
        else
           # GenServer.cast(String.to_atom(Use.sha_1(node)),:update)
            if (up_node<r and r<Enum.at(fing,0)) or (up_node<r and r>Enum.max(fing)) do
              #IO.inspect("If in findfinger")
                #GenServer.cast(String.to_atom(Use.sha_1(node)),:update)
                hops
            else
                if up_node<r do
                    #IO.puts "main 1 #{hops}"
                    findbetween(i,fing,r,node,up_node,hops)
                else
                    if up_node>r do
                        #IO.inspect hops
                        #IO.puts "main 2 #{hops}"
                      findbetween2(i,fing,r,node,up_node,hops)
                    end
                end

            end
        end
        newhop
    end
    # def findbetween(len,fing,r,node,up_node,hops) do
    # end
    # def findbetween2(len,fing,r,node,up_node,hops) do
    # end
    def findbetween(i,fing,r,node,up_node,hops) do
        len=Enum.count(fing)
        # IO.puts "btw 1"
        # IO.inspect hops
        finalhops = if(i < len) do
            #newhops = if i<Enum.count(fing) do
                if r>Enum.at(fing,i) and r<Enum.at(fing,i+1) do
               # IO.inspect hops
                 fingggg(Enum.at(fing,i),r,node,hops)
                else
                    if r>Enum.at(fing,i) and r>Enum.at(fing,i+1) and Enum.at(fing,i)>Enum.at(fing,i+1) do
              #          IO.inspect hops
                        fingggg(Enum.at(fing,i),r,node,hops)
                    else
                        if i+1==len-1 and r>Enum.at(fing,len-1) do
             #               IO.inspect hops
                            fingggg(Enum.at(fing,i+1),r,node,hops)
                        else
                            findbetween(i+1,fing,r,node,up_node,hops)
                        end
                    end
                end
            # else
            #     hops
            # end
            #IO.inspect newhops
            #findbetween(i+1,fing,r,node,up_node,newhops)
        else
            hops
        end
        finalhops
    end

    def findbetween2(i,fing,r,node,up_node,hops) do
        len=Enum.count(fing)
        # IO.puts "btw 2"
        # IO.inspect hops
        finalhops = if(i<len) do
            #newhops = if i<Enum.count(fing) do
                if r>Enum.at(fing,i) and r<Enum.at(fing,i+1) do
                    #IO.inspect hops
                 fingggg(Enum.at(fing,i),r,node,hops)
                else
                    if r<Enum.at(fing,i) and r<Enum.at(fing,i+1) and Enum.at(fing,i)>Enum.at(fing,i+1) do
                        #IO.inspect hops
                        fingggg(Enum.at(fing,i),r,node,hops)
                    else
                        if i+1==len-1 and r>Enum.at(fing,len-1) do
                            #IO.inspect hops
                            fingggg(Enum.at(fing,i+1),r,node,hops)
                        else
                            if i+1==len-1 and r<Enum.at(fing,len-1) do
                                #IO.inspect hops
                                fingggg(Enum.at(fing,i+1),r,node,hops)
                            else
                                findbetween2(i+1,fing,r,node,up_node,hops)
                            end
                        end
                    end
                end
            # else
            #     hops
            # end
            #findbetween2(i+1,fing,r,node,up_node,newhops)
        else
            hops
        end
        finalhops
    end
   # def dothis(fing,rand,node) do
    #
       # if rand>Enum.at
       # if(Enum.member?(fing,rand)==true) do

    def sha_1(p) do
        :crypto.hash(:sha,to_string(p))|>Base.encode16|>String.downcase()
    end
    def find_successor(list,p) do
        if p>0 do
         g=Enum.find_index(list,fn y-> y==p end)
            if length(list)==g+1 do
             Enum.at(list,0)
            else
                if p==Enum.at(list,0) do
                    Enum.at(list,1)
                else
                    Enum.at(list,g+1)
                end
            end
        end
    end
    def find_predecessor(list,p) do
        if p>0 do
         g=Enum.find_index(list,fn y-> y==p end)
            if length(list)==g+1 do
             Enum.at(list,g-1)
            else
                if p==Enum.at(list,0) do
                    Enum.at(list,(length(list)-1))
                else
                    Enum.at(list,g-1)
                end
            end
        end
    end
    def find_m(num_nodes,c) do
        if :math.pow(2,c) < num_nodes do
          find_m(num_nodes,c+1)
        else
          round(:math.pow(2,c))
        end
    end
    def create_fingertable(k,p,finger_table,z,u) do
        if z<round(:math.log2(u)) do
            sum=p+round(:math.pow(2,z))
            if rem(sum,u) < u do
                #IO.inspect("hello")
                o=rem(sum,u)
                if(Enum.member?(k,o)==true) do
                    #IO.inspect("This #{o}")
                   # IO.inspect("if")
                    finger_table=append(finger_table,o,k)
                    create_fingertable(k,p,finger_table,z+1,u)

                else
                   # IO.inspect("else")
                    if o==0 do
                        if(Enum.member?(k,u)==true) do
                           # IO.inspect("else lo if lo if")

                            finger_table=append(finger_table,u,k)
                            create_fingertable(k,p,finger_table,z+1,u)
                        else
                            #IO.inspect("Else lo if lo else")
                            o=Enum.at(k,0)
                            finger_table=append(finger_table,o,k)
                            create_fingertable(k,p,finger_table,z+1,u)
                        end
                    else
                        if o<Enum.at(k,0) or o>Enum.at(k,Enum.count(k)-1) do
                         #IO.inspect("inko if")
                         o=Enum.at(k,0)
                         finger_table=append(finger_table,o,k)
                         create_fingertable(k,p,finger_table,z+1,u)
                        else
                         v=0
                         lol=1
                         #IO.inspect("not if else")
                         o=find_place(o,k,v,lol)
                         finger_table=append(finger_table,o,k)
                         #IO.inspect(finger_table)
                         create_fingertable(k,p,finger_table,z+1,u)
                        end
                    end
                end
            end
        else
            finger_table
        end
    end
    def append(finger_table,o,k) do
          finger_table ++ [o]
    end
    def find_place(o,k,v,lol) do
        if o>Enum.at(k,v) and o<Enum.at(k,lol) do
            #IO.inspect("ikkada")
            Enum.at(k,lol)
        else
            find_place(o,k,v+1,lol+1)
        end
    end
end
