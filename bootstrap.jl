(pwd() != @__DIR__) && cd(@__DIR__) # allow starting app from bin/ dir

using BitempWebApp
push!(Base.modules_warned_for, Base.PkgId(BitempWebApp))
BitempWebApp.main()
