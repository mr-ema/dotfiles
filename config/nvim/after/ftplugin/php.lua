local lsp = require('lsp-zero')

-- Ensure LSP server is available
lsp.ensure_installed({ 'intelephense' })

-- Configure Intelephense LSP
require'lspconfig'.intelephense.setup({
    settings = {
        intelephense = {
            stubs = {
                "bcmath", "bz2", "calendar", "Core", "curl", "date", "dba",
                "dom", "enchant", "fileinfo", "filter", "ftp", "gd", "gettext",
                "hash", "iconv", "imap", "intl", "json", "ldap", "libxml", "mbstring",
                "mcrypt", "mysql", "mysqli", "password", "pcntl", "pcre", "PDO",
                "pdo_mysql", "Phar", "readline", "recode", "Reflection", "regex",
                "session", "SimpleXML", "soap", "sockets", "sodium", "SPL", "standard",
                "superglobals", "sysvsem", "sysvshm", "tokenizer", "xml", "xdebug",
                "xmlreader", "xmlwriter", "yaml", "zip", "zlib", "wordpress", "woocommerce",
                "acf-pro", "acf-stubs", "wordpress-globals", "wp-cli", "genesis", "polylang",
                "sbi"
            },
            diagnostics = { enable = true },
            environment = {
                includePaths = '~/.composer/vendor/php-stubs/' -- this line forces the composer path for the stubs in case inteliphense don't find it...
            },
            files = {
                maxSize = 10000000
            }
        }
    }
})

-- Make sure lsp-zero is working
lsp.setup()
