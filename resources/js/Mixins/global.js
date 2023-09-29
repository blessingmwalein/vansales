export default {
    data() {
        return {

        }
    },
    created: function () { },
    methods: {

        //fire snackbar
        fireSnackbar(message, title, color, type = "infor") {
            this.$snackbar.add({
                type: type,
                info: type,
                background: color,
                text: message,
                title: title,
            });
        },

        //create function to copy text to clipboard
        copyToClipboard(text) {
            var dummy = document.createElement("textarea");
            document.body.appendChild(dummy);
            dummy.value = text;
            dummy.select();
            document.execCommand("copy");
            document.body.removeChild(dummy);

            this.fireSnackbar("Copied to clipboard", "Copied",'#008000', "success");
        },
    },
};
