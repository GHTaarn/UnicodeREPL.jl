using Test
using UnicodeREPL

@testset "substitution" begin
    @test UnicodeREPL.substitution("\\u(2560)\\u(2563)ello World!") == "╠╣ello World!"
    @test UnicodeREPL.substitution("\\u(bed) \\u(cab) \\u(feed) \\u(dad) \\u(BEEF)") == "௭ ಫ ﻭ ත 뻯"
    @test UnicodeREPL.substitution("\\u(1F607) \\u(3b1)\\u(20E8)") == "😇 α⃨"
end
