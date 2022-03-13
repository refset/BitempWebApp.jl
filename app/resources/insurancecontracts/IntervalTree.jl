module IntervalTree
using AbstractTrees
import AbstractTrees: children, printnode
import BitemporalPostgres
using BitemporalPostgres
import SearchLight
using SearchLight
export Node, n0,n2, print_tree

struct Node
    interval::ValidityInterval
    shadowed::Vector{Node}
end

function children(n::Node)
    return n.shadowed
end

printnode(io::IO, n::Node) = print(io, n.interval.id)

n0=Node(ValidityInterval(),Node[])
n2=Node(ValidityInterval(),[Node(ValidityInterval(),[]),Node(ValidityInterval(),[])])
print_tree(n2)

function mktree(hid::DbId) 
    forest=find(ValidityInterval,SQLWhereExpression("ref_history=? AND tsrdb @> now()",1))
    for p in forest
        shadowed = find(ValidityInterval,SQLWhereExpression("ref_history=? AND tsdb_invalidfrom=? AND tstzrange(?,?) * tsrworld = tsrworld",1,p.tsdb_validfrom,p.tsworld_validfrom,p.tsworld_invalidfrom ))
        if !isempty(shadowed)
            print("hurra")
            println(shadowed[1])
            return shadowed
        end
    end
end

SearchLight.Configuration.load() |> SearchLight.connect
mktree(DbId(1))

end