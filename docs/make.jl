push!(LOAD_PATH,"..")
using Documenter
using gps

makedocs(
    sitename = "gps",
    format = Documenter.HTML(),
    modules = [gps]
)

# Documenter can also automatically deploy documentation to gh-pages.
# See "Hosting Documentation" and deploydocs() in the Documenter manual
# for more information.
deploydocs(
    repo = "github.com/4e554c4c/gps.git",
    devbranch = "main"
)
