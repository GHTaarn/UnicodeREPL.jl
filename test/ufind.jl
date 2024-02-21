using Test
using UnicodeREPL

@testset "ufind" begin
    @test ufind(r"^\\alpha$") == ["\\alpha" => "α"]
    @test ("\\div" => "÷") in ufind("div")
    @test "ﻭ" ∉  values(ufind("feed"))
    @test "\ufeed" ∉  values(ufind("feed"))
end

