import Ember from 'ember';

const options = [
  Ember.Object.create({ value: 0, label: "first" }),
  Ember.Object.create({ value: 1, label: "second" }),
  Ember.Object.create({ value: 2, label: "third" }),
  Ember.Object.create({ value: 3, label: "fourth" }),
  Ember.Object.create({ value: -2, label: "nextToLast" }),
  Ember.Object.create({ value: -1, label: "last" })
];

export default options;
