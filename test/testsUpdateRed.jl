# update Contract red
@testset "UpdateContractRed" begin
    cr2 = ContractRevision(ref_component = c.id, description = "red")
    w3 = Workflow(
        ref_history = w2.ref_history,
        tsw_validfrom = ZonedDateTime(2015, 5, 30, 21, 0, 1, 1, tz"Africa/Porto-Novo"),
    )
    update_entity!(w3)
    update_component!(cr1, cr2, w3)
    commit_workflow!(w3)
    @test w3.ref_history == w2.ref_history

    # end of mutations
end

hforest = mkforest(DbId(3), MaxDate, ZonedDateTime(1900, 1, 1, 0, 0, 0, 0, tz"UTC"), MaxDate)
print_tree(hforest)

end
