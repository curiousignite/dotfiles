return {
    "numToStr/Navigator.nvim",
    config = function()
        require("Navigator").setup()
        require('Navigator').left()
        require('Navigator').right()
        require('Navigator').up()
        require('Navigator').down()
        require('Navigator').previous()
    end
}
