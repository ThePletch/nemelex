module.exports = {
  "extends": ["airbnb-base"],
  "env": {
    "browser": true
  },
  "globals": {
    "$": false,
    "window": false,
    "document": false
  },
  "rules": {
    "max-len": 0,
    "no-param-reassign": 0,
    "arrow-parens": [2, "as-needed"],
    "arrow-body-style": 0,
    "quotes": 0,
    "no-underscore-dangle": ["error", { "allowAfterThis": true}],
    "key-spacing": ["error", { "align": "value" }],
    "import/extensions": ["error", "never"],
    "import/prefer-default-export": 0,
    "import/first": 0,
    "class-methods-use-this": 0,
    "no-console": [1, { "allow": ["warn", "error"] }],
    "strict": 1
  }
};
