# Identicon

Project focused in generating a Identicon (avatar) using Elixir Image Manipulation
For more details about what is an Identicon, you can read it [here](https://github.blog/2013-08-14-identicons/).

## Main Goal

The main goal of this application is to create a Module that enables the user to generate from a specific string always the same image, having then a unique avatar per username, similar with what GitHub does if you do not have an image uploaded.

- Parse input String
- Collect from it a list of hexadecimals
- From them extract a color
- From them extract a set of forms
- Generate a grid and fill the selected squares
- Save image with input name

## Docs

To generate the Docs of the module it is necessary just to open a terminal window, inside the base folder of the module and then type

```
mix docs
```

## Testing

Elixir has a quite rich out-of-the-box testing support, so additional plugins or libraries are not needed in order to make the tests run or you to right them. Go to the base folder of the module and then type

```
mix test
```

## Installation

### Docker

`WIP...`

### Local stack

#### Elixir

Excelent tutorial on official [doc](https://elixir-lang.org/install.html)

#### After clone

In order to download all the dependencies needed for the application to work run

```
mix deps.get
```

## References

This application was suggested as dive in project to get more practice in Elixir, in the excelent [Stephen Grider's course at Udemy](https://www.udemy.com/the-complete-elixir-and-phoenix-bootcamp-and-tutorial).
