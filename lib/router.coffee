Router.configure 
  layoutTemplate: "layout"

Router.map ->
  @route "whatever",
    path: "/"

  @route 'admin',
    path: "philzelonky"

  @route 'collegetour',
    path: "/collegetour"



