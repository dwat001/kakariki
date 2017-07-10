var viewModel;

function Person(name, age, id, isEditing, status) {
    this.name = ko.observable(name);
    this.age = ko.observable(age);
    this.id = ko.observable(id);
    this.isEditing = ko.observable(isEditing);
    this.status = ko.observable(status);
}

$(function () {
    /*
    var cache = Modernizr.applicationcache;
    var localStoragePresent = Modernizr.localstorage;
    var webSocket = Modernizr.websockets;
    var webWorkers = Modernizr.webworkers;
    */

    viewModel = {
        'people': null,

        populatePeople: function () {
            if (this.hasLocalStoragePeople()) {
                this.people = this.fetchLocalStoragePeople();
            } else {
                this.people = this.createDefaultPeople();
            }
        },

        hasLocalStoragePeople: function () {
            var storedPeopleString = localStorage["People"];
            return storedPeopleString != "null" && storedPeopleString != "";
        },

        fetchLocalStoragePeople: function () {
            var storedPeopleString = localStorage["People"];
            var peopleAry = JSON.parse(storedPeopleString);
            var observablePeople = ko.utils.arrayMap(peopleAry,
                    function (person) {
                        return new Person(person.name, person.age, person.id, person.isEditing, person.status);
                    });
            return ko.observableArray(observablePeople);
        },


        createDefaultPeople: function () {
            return ko.observableArray([
                    new Person("David", 33, 6, false, "default"),
                    new Person("Mary", 45, 19, false, "default")]);
        },

        addPerson: function () {
            this.people.push(new Person("", null, null, true, "new"));
        },

        removePerson: function (person) {
            person.status('deleted');
            this.people.destroy(person);
        },

        editPerson: function (person) {
            person.isEditing(true);
        },

        savePerson: function (person) {
            person.isEditing(false);
            person.status("altered");
        },

        cancelEditPerson: function (person) {
            person.isEditing(false);
        },

        saveLocal: function () {
            for (var index in this.people()) {
                this.people()[index].status("SavedLocal");
            }

            localStorage["People"] = ko.toJSON(this.people);
            alert(localStorage["People"]);
        },

        clearLocal: function () {
            localStorage["People"] = "";
        }

    };
    viewModel.populatePeople();

    viewModel.localStorageChanges = ko.observableArray([]);



    window.addEventListener("storage", function (e) {
        if (!e) { e = window.event; }
    },
        false);

    ko.applyBindings(viewModel, $('#pesonForm')[0]);
})
