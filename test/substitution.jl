using Test
using UnicodeREPL

@testset "substitution" begin
    @test UnicodeREPL.substitution("\\u(2560)\\u(2563)ello World!") == "╠╣ello World!"
    @test UnicodeREPL.substitution("\\u(bed) \\u(cab) \\u(feed) \\u(dad) \\u(BEEF)") == "௭ ಫ ﻭ ත 뻯"
end
