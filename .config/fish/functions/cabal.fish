function cabal --wraps cp
    if test "$argv[1]" = repl
        command cabal repl \
            --repl-options "-interactive-print=Text.Pretty.Simple.pPrint" \
            --build-depends pretty-simple \
            $argv[2..-1]
    else
        command cabal $argv
    end
end
