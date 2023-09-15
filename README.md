# Formify
Formify is a versatile and customizable form handling library for Flutter, designed to simplify the process of creating and managing forms in your Flutter applications. With Formify, you can effortlessly build dynamic forms, validate user input, and handle form submission with ease.

## Features
Formify provides a variety of features to help you create and manage forms, including:

- **Dynamic Form Generation**: Formify provides a clean and intuitive way to generate forms dynamically based on your data model.
- **Customizable Fields**: Customize form fields, labels, icons, validation rules, and more to match your app's design and requirements. 
- **Validation Rules**: Easily apply built-in or custom validation rules to validate user input and provide meaningful error messages. 
- **Real-time Validation**: Formify performs real-time validation as users interact with the form, giving immediate feedback on the validity of their input. 
- **Error Handling**: Manage and display validation errors effortlessly, making it clear to users where corrections are needed. 
- **Efficient State Management**: Formify efficiently manages the state of your form fields, reducing the complexity of state management in Flutter apps. 
- **Rich Text Editing**: Support for various input types, including text, numeric, email, multiline, and more. 
- **Password Toggling**: Create password fields with toggleable visibility for user convenience.

## Usage

create a class that extends Family Forms, and prepare the attributes that will be used, 
you can use the following code:

```dart
class FormDemo extends FormifyForms {
  @override
  List<Attribute> get attributes => [
    FormifyAttribute('username'),
    FormifyAttribute('password', FormifyType.password),
  ];
}
```
The `getWidgets()` method returns a list of widgets that represent the form fields. You can use this method to add the form fields to your app.

For example, the following code would add the form fields to a Column widget:

```dart
...
Column(
  children: formDemo.getWidgets(),
)
...
```

You can also use the spread operator (`...`) to add the form fields to other widgets. For example, 
the following code would add the form fields to a Column widget:

```dart
...
Column(
  children: [
    ...formDemo.getWidgets(),
    FilledButton(
      onPressed: () {},
      child: const Text('Login'),
    ),
  ],
)
...
```

<img width="250" src="https://raw.githubusercontent.com/teknologicakrainternasional/formify/master/images/Screenshot_20230913-205122.png"/>

You can also create a horizontal form layout by using `FormifyRowAttribute` in conjunction with `FormifyAttribute`. 
Here's an example code snippet demonstrating how to achieve this:
```dart
class FormDemo extends FormifyForms {
  @override
  List<Attribute> get attributes => [
    FormifyAttribute('username'),
    FormifyAttribute('password', FormifyType.password),
    FormifyRowAttribute([
      FormifyAttribute('phone_number', FormifyType.phone),
      FormifyAttribute('email_address', FormifyType.email),
    ]),
  ];
}
```
<img width="250" src="https://raw.githubusercontent.com/teknologicakrainternasional/formify/master/images/Screenshot_20230915-191931.png"/>

## Documentation

### Attribute Types

```dart
class FormDemo extends FormifyForms {
  @override
  List<Attribute> get attributes => [
    FormifyAttribute('username'),
    FormifyAttribute('password', FormifyType.password),
  ];
}
```
This code defines a class called `FormDemo` that extends the `FormifyForms` class. The `FormifyForms` 
class is a base class that provides common functionality for all form fields. 
The `attributes` property is a map that maps attribute names to attribute values. 
In this case, the `username` attribute is set to the value `FormifyType.text` (if not defined) and 
the `password` attribute is set to the value `FormifyType.password`.


| Type                    | Description                                                             |
|-------------------------|-------------------------------------------------------------------------|
| `FormifyType.text`      | The default type. It returns a generic `TextFormField`.                 |
| `FormifyType.numeric`   | The keyboard that appears is a numeric keyboard.                        |
| `FormifyType.password`  | The `obscureText` property is set to `true`.                            |
| `FormifyType.email`     | The keyboard that appears is an email keyboard.                         |
| `FormifyType.multiline` | The keyboard that appears is a multiline keyboard.                      |
| `FormifyType.phone`     | The keyboard that appears is a phone keyboard.                          |
| `FormifyType.name`      | The `TextCapitalization` property is set to `TextCapitalization.words`. |


### Custom Label
By default, the label that will be displayed on a text form field will take the key of 
the attribute that was previously created, with underscores replaced by spaces and the first letter 
capitalized. For example, if the attribute is fist_name, the label will be First Name.

You can also customize the label by adding the `labels` property, as shown in the following example:
```dart
class FormDemo extends FormifyForms {
  @override
  List<Attribute> get attributes => [
    FormifyAttribute('username'),
    FormifyAttribute('password', FormifyType.password),
  ];
  
  @override
  Map<String, String> get labels => {
    'username': 'Username or Email Address',
  };
}
```
You don't need to define all of the attributes, just the ones you want to change.

<img width="250" src="https://raw.githubusercontent.com/teknologicakrainternasional/formify/master/images/Screenshot_20230913-214853.png"/>

### Validation
You can customize validation rules by adding the `rules` property, as shown in the following example:
```dart
...
@override
Map<String, List<FormifyRule>> get rules => {
  'username': [FormifyRule.required],
  'password': [FormifyRule.required, FormifyRule.min(5)],
};
```

The `rules` property is a map that maps attribute names to a list of validation rules. In this example, the `username` attribute is required and the `password` attribute is required and must be at least 5 characters long.

If the user enters an invalid value for an attribute, an error message will be displayed. The error message will be customized based on the validation rule. For example, if the user enters an empty value for the `username` attribute, the error message will be "Username is required."

<img width="250" src="https://raw.githubusercontent.com/teknologicakrainternasional/formify/master/images/Screenshot_20230913-221011.png"/>

The following is a list of the available validation rules:

| Rule        | Example                                       | Description                                                                  |
|-------------|-----------------------------------------------|------------------------------------------------------------------------------|
| required    | `FormifyRule.required `                       | The field is required. The form will not be submitted if the field is empty. |
| numeric     | `FormifyRule.numeric`                         | The field must be number.                                                    |
| integer     | `FormifyRule.integer`                         | The field must be integer.                                                   |
| double      | `FormifyRule.double`                          | The field must be double value.                                              |
| between     | `FormifyRule.between(1, 2)`                   | The field must be a number between 1 and 2.                                  |
| min         | `FormifyRule.min(10)`                         | The field must contain at least 10 characters.                               |
| max         | `FormifyRule.max(10)`                         | The field must contain at most 10 characters.                                |
| gt          | `FormifyRule.gt(10)`                          | The field must be a number greater than 10.                                  |
| gte         | `FormifyRule.gte(10)`                         | The field must be a number greater than or equal to 10.                      |
| lt          | `FormifyRule.lt(10)`                          | The field must be a number less than 10.                                     |
| lte         | `FormifyRule.lte(10)`                         | The field must be a number less than or equal to 10.                         |
| starts_with | `FormifyRule.starts_with('mr')`               | The field must start with the value 'mr'.                                    |
| ends_with   | `FormifyRule.ends_with('S.Kom')`              | The field must end with the value 'S.Kom'.                                   |
| same        | `FormifyRule.same('good')`                    | The field must be the same as the value 'good'.                              |
| lowercase   | `FormifyRule.lowercase`                       | The field must be lowercase.                                                 |
| uppercase   | `FormifyRule.uppercase`                       | The field must be uppercase.                                                 |
| alpha_num   | `FormifyRule.alphaNumeric`                    | The field must be string or number                                           |
| email       | `FormifyRule.email`                           | The field must be valid email address                                        |
| ip          | `FormifyRuleip`                               | The field must be valid IP address                                           |
| url         | `FormifyRule.url`                             | The field must be valid URL                                                  |
| in          | `FormifyRule.inItems(['you','me','they'])`    | The field must one in the list                                               |
| not_in      | `FormifyRule.notInItems(['you','me','they'])` | The field must not one in the list                                           |
| regex       | `FormifyRule.regEx(r"^dog")`                  | The field must match regex expression                                        |

You can also create custom validation rules by defining a class that extends `FormifyRule`
and then adding it to your `rules` property. For example:

```dart
class MyPhoneValidation extends FormifyRule{
  @override
  String? call(String attribute, String value) {
    RegExp phoneNumberRegex = RegExp(r'^\+26\d{10,}$');
    if (!phoneNumberRegex.hasMatch(value)) {
      return '$attribute should start with +26 and minimum 12 digit';
    }
    return null;
  }
}
```

```dart

@override
Map<String, List<FormifyRule>> get rules => {
  'phone_number': [FormifyRule.required, MyPhoneValidation()],
};
```

You can further customize validation messages by utilizing the `validationMessage` property,
This property allows you to define custom messages for specific validation rules. 
Simply include the validation rule followed by your desired message. 
The system will automatically replace placeholders such as  `:attribute` and `:input` 
with the corresponding attribute name and user input.  Additionally, you can use specific type 
placeholders like `:number`, `:min`, `:max`, `:pattern`, and `:items` to represent actual values.

```dart
...
@override
Map<String, String> get validationMessage => {
  'min': 'The :attribute must contain at least :number characters.'
  'between': 'The :attribute value :input is not between :min and :max.'
  'in': 'The :attribute is not between :min and :max.'
  'starts_with': 'The :attribute must start with :pattern'
};
```
By default, Formify will automatically validate your input. 
However, you can change this by adding the `isAutoValidation` property and setting it to `false`.

```dart
...
@override
bool get isAutoValidation => false;
```

Then, you can validate your form by calling the `isFormValid()` function. This function returns a `bool`, 
which you can use to decide what to do next.

```dart
FilledButton(
  onPressed: () {
    if(formDemo.isFormValid()){
      //DO SOMETHING
    }
  },
  child: const Text('Login'),
),
```
### Manual Error Message
You can manually set error message by call `addErrorMessage`, `setErrorMessage`, or `setErrorMessages` function, for example:

`addErrorMessage` append error message to existing list error message. 
```dart
FilledButton(
  onPressed: () {
    formDemo.addErrorMessage('username', 'manual error message');
  },
  child: const Text('Login'),
),
```

`setErrorMessage` replace error message to existing one error message.
```dart
FilledButton(
  onPressed: () {
    formDemo.setErrorMessage('username', 'manual error message');
  },
  child: const Text('Login'),
),
```

`setErrorMessages` replace error message to existing list error message.
```dart
FilledButton(
  onPressed: () {
    formDemo.setErrorMessages('username', ['manual error message', 'manual error message too']);
  },
  child: const Text('Login'),
),
```

### Customize Form Widget (InputDecoration)
You can customize your text form field by adding the `inputDecoration` property and setting it to your desired values.

```dart
@override
InputDecoration? get inputDecoration =>
    const InputDecoration(
      border: OutlineInputBorder(),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.purple),
      ),
    );
```
<img width="250" src="https://raw.githubusercontent.com/teknologicakrainternasional/formify/master/images/Screenshot_20230913-231705.png"/>

### Customize Form Widget (formBuilder)
If you want to customize more deeply, you can do so by adding the `formBuilder` property. 
The form builder is a function that returns a `widget` and takes three parameters: 
`BuildContext`, `Formify` object, and `FormifyTextField` widget.

The `Formify` object allows you to get the following values:

- `attribute`: The attribute key of the field
- `type`: The `FormifyType` of the field
- `label`: The label of the form
- `value`: The value that has been entered
- `errors`: The error values in a list of strings, if any
- `error`: The error value in a string
- `isLoading`: A boolean value that indicates if the form is in a loading state. This is typically used to make the form readonly when it is loading.
- `isRequired`: A boolean value that indicates if the form is required, when its rules contain FormifyRule.required.
- `formKey`: The `GlobalKey<FormFieldState>` of the form that you are modifying
- `controller`: The `TextEditingController` of the form that you are modifying
- `keyboardType`: The `TextInputType` of the form that you are modifying
- `textCapitalization`: The `TextCapitalization` of the form that you are modifying
- `obscureText`: The `obscureText` of the form that you are modifying
- `onChanged`: function that can update the value of your form.
- `clearErrorMessages`: function that can clear error message of your form.
- `toggleObscureText`: function that can toggle obscureText of your form.

The `FormifyTextField` widget is a custom widget contain `TextFormField` widget. 
Because of that you can change its properties by using the `copyWith()`.
the properties almost identical with `TextFormField`.

For example, if you want to make two different prefix icons for the username and password fields, 
you can modify the `FormifyTextField` with the `copyWith()` method and return it.

```dart
@override
FormifyFormBuilder? get formBuilder => (
    BuildContext context, 
    Formify formify, 
    FormifyTextField child,
) {
  if (formify.attribute == 'username') {
    return child.copyWith(prefixIcon: const Icon(Icons.person));
  }
  if (formify.attribute == 'password') {
    return child.copyWith(prefixIcon: const Icon(Icons.lock));
  }
  return child;
};
```
<img width="250" src="https://raw.githubusercontent.com/teknologicakrainternasional/formify/master/images/Screenshot_20230914-000015.png"/>

`formBuilder` allows you to create a completely new widget.
The `formBuilder` function will be called whenever there is a change in the value, loading state, 
or error state for any of its attributes.

### Customize Form Separator Widget
Formify separates the form with a `SizedBox` with a height of 16. If you don't think this is suitable, 
you can modify it by adding the `separatorBuilder` property, as shown in the following example:

```dart
@override
FormifySeparatorBuilder? get separatorBuilder => (
  BuildContext context,
  Formify formify,
  Widget child,
) {
  return const SizedBox(height: 20);
};
```

### Initial Value
Let's say in the case of an edit form, you will need an initial value to fill in the initial value of your form. You can do this in two ways.

set initial value once at a time.
```dart
@override
void initState() {
  super.initState();
  formDemo.setInitialValue('username', 'thisismyusername');
}
```

set initial value once in bulk.
```dart
@override
void initState() {
  super.initState();
  formDemo.setInitialValues({
    'username': 'thisismyusername',
    'password': 'password',
  });
}
```