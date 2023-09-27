export default {
    data() {

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

       
    },
};
