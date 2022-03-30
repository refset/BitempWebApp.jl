# update Contract yellow
@testset "UpdateContractYellow" begin

    cr1 = ContractRevision(ref_component = c.id, description = "yellow")
    w2 = Workflow(
        ref_history = w1.ref_history,
        tsw_validfrom = ZonedDateTime(2016, 5, 30, 21, 0, 1, 1, tz"Africa/Porto-Novo"),
    )
    update_entity!(w2)
    update_component!(cr, cr1, w2)
    commit_workflow!(w2)
    @test w2.ref_history == w1.ref_history

end
