import Ember from 'ember';

const options = [
  Ember.Object.create({ value: 0, label: "sunday" }),
  Ember.Object.create({ value: 1, label: "monday" }),
  Ember.Object.create({ value: 2, label: "tuesday" }),
  Ember.Object.create({ value: 3, label: "wednesday" }),
  Ember.Object.create({ value: 4, label: "thursday" }),
  Ember.Object.create({ value: 5, label: "friday" }),
  Ember.Object.create({ value: 6, label: "saturday" })
];

export default options;
