require("neorg").setup({
    load = {
        ["core.defaults"] = {},
        ["core.concealer"] = {},
        ["core.dirman"] = {
            config = {
                workspaces = {
                    notes = "~/notes",
                    politie = "~/notes/politie-notes/",
                    persoonlijk = "~/notes/persoonlijk-notes/",
                    cyber = "~/notes/cyber-sec/"

                },
                default_workspace = "notes"
            },
        },
    },
})
