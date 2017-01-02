import Ember from 'ember';

const options = [
  Ember.Object.create({ value: 1, label: "first" }),
  Ember.Object.create({ value: 2, label: "second" }),
  Ember.Object.create({ value: 3, label: "third" }),
  Ember.Object.create({ value: 4, label: "fourth" }),
  Ember.Object.create({ value: -2, label: "nextToLast" }),
  Ember.Object.create({ value: -1, label: "last" })
];

export default options;
