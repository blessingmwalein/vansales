export default {
    data() {
        return {

        }
    },
    filters: {
        formatField(value) {
            // Split the string at underscores, capitalize each word, and join with spaces
            return value.split('_').map(word => word.toUpperCase()).join(' ');
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

            this.fireSnackbar("Copied to clipboard", "Copied", '#008000', "success");
        },

        getStatusBackGroundColor(status) {
            //switch case
            switch (status) {
                case 'Draft':
                    return 'bg-yellow-300 text-yellow-800';
                    break;
                case 'Created':
                    return 'bg-green-500 text-white';
                    break;
                case 'Cancelled':
                    return 'bg-red-500 text-white';
                    break;
                case 'Confirmed':
                    return 'bg-blue-500 text-white';
                    break;
                case 'Loaded':
                    return 'bg-gray-500 text-white';
                    break;
                default:
                    return 'bg-gray-500 text-white';
                    break;
            }
        },
        formatField(value) {
            // Split the string at underscores, capitalize each word, and join with spaces
            return value.split('_').map(word => word.toUpperCase()).join(' ');
        },

        getLoadsheetChangedFromDescription(description) {
            //we want to extract changed from description this formart Loadsheet Updated fields Changes:{"user_id":8,"truck_id":6,"updated_at":"2023-10-01 22:18:59"} convert to array of objects of formaty [{user_id: 8}, {truck_id: 6}]
            const jsonPart = description.split('Changes:')[1];
            if (!jsonPart) {
                return [];
            }
            // Parse the JSON into an object
            const changesObj = JSON.parse(jsonPart);
            // Convert the object into an array of objects
            const changesArray = Object.keys(changesObj).map((key) => ({ [key]: changesObj[key] }));
            return changesArray;
        },

        getTextPartFromDescription(description) {
            const textPart = description.split('Changes:')[0];
            return textPart;

        },

        //create function 
    },
};
