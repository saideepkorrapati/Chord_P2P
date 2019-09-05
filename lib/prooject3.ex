defmodule Pro3 do
    #use GenServer
    def main(args) do
        args|>parse
    end
    def parse([num_nodes,num_reqs]) do
        num_nodes=elem(Integer.parse(num_nodes),0)
        num_reqs=elem(Integer.parse(num_reqs),0)
        c=0
        b=0
        nearest_m=Use.find_m(num_nodes,c)
        l=Enum.map(1..nearest_m,&(&1))
        ar=Enum.take_random(l,num_nodes)
        node_list=Enum.sort(ar)
     #   IO.inspect(node_list)
        start_nodes(node_list,num_nodes,num_reqs,b,nearest_m)
        start_reqs(node_list,num_nodes,num_reqs,b,nearest_m)
        count_hops(node_list,num_nodes,b)
        hopsum(node_list,num_reqs)
        #avg_hopss(node_list,num_nodes,b)
       # IO.inspect("came out")
        #rand=Enum.random(node_list)
        #IO.inspect(rand)
        #IO.inspect(String.to_atom(to_string(rand)))
        #Nodes.funtemp(String.to_atom(to_string(rand)))
        #GenServer.cast(String.to_atom(Use.sha_1(rand)),:yo)
        #GenServer.cast(String.to_atom(to_string(rand)),{:yo,1})
        funloop(1)
    end
    def funloop(1) do
        funloop(1)
    end
    # def handle_cast({:yo,a},state) do
    #     IO.inspect("uo1")
    #     IO.inspect(state.finger_table)
    #     IO.inspect("uo2")
    #     {:noreply,state}
    # end
    def start_nodes(node_list,num_nodes,num_reqs,b,nearest_m) do
        if b<=num_nodes-1 do
            present_node=Enum.at(node_list,b)
            #IO.inspect(String.to_atom(Use.sha_1(present_node)))
            GenServer.start_link(Nodes,%{whole_list: nearest_m,node_list: node_list,n: num_nodes,node: present_node,finger_table: [],suc: 0,pre: 0,avg_hops: 0,message_count: num_reqs,id: present_node}, name: String.to_atom(Use.sha_1(present_node)))
            #IO.inspect tar
            start_nodes(node_list,num_nodes,num_reqs,b+1,nearest_m)
        end
    end
    def start_reqs(node_list,num_nodes,num_reqs,b,nearest_m) do
        if b<=num_nodes-1 do
            the_node=Enum.at(node_list,b)
            count=num_reqs
            Use.foo(count,the_node)
            start_reqs(node_list,num_nodes,num_reqs,b+1,nearest_m)
        end
    end
    def count_hops(node_list,num_nodes,b) do
        if b<=num_nodes-1 do
            the_node=Enum.at(node_list,b)
            GenServer.cast(String.to_atom(Use.sha_1(the_node)),:yolo)
           # IO.inspect("-----------")
            count_hops(node_list,num_nodes,b+1)
        end

    end

    def hopsum(node_list,num_reqs) do
        li = Enum.map(node_list, fn(x) ->
                hop=Nodes.nodeHops(String.to_atom(Use.sha_1(x)))
                hop
             end)
         x = Enum.count(node_list)
         sum = Enum.sum(li)

         avg = (sum)/(x*num_reqs)
         IO.inspect ("Average Hops #{avg}")
         System.halt(1)
    end





end
