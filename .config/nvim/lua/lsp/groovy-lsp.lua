-- REQUIREMENTS:
-- Linux or MacOS
-- Java 11+
require 'lspconfig'.groovyls.setup {
    -- Unix
    cmd = { "java", "-jar", "path/to/groovyls/groovy-language-server-all.jar" }
}
