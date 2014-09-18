# Jagged border

![](https://raw.githubusercontent.com/shgtkshruch/jagged-border/master/jagged-border.png)

## Mixin

```
@mixin jagged-border($main-color, $size: 20px) {
  $unit: 100% / 3;
  
  &:before {
    content: '';
    position: absolute;
    top: $size / -2;
    width: 100%;
    height: $size / 2;
    background: 
      linear-gradient(
        45deg,
        transparent $unit,
        $main-color $unit,
        $main-color $unit * 2,
        transparent $unit * 2
      ),
      linear-gradient(
        -45deg,
        transparent $unit,
        $main-color $unit,
        $main-color $unit * 2,
        transparent $unit * 2
      );
    background-size: $size $size * 2;
  }
}
```

## Usage

```
.jagged-border {
  background-color: whitesmoke;
  @include jagged-border(whitesmoke, 40px);
}
```

## Demo

Demo: [http://shgtkshruch.github.io/jagged-border](http://shgtkshruch.github.io/jagged-border)

## Thanks

inspired by [jagged border](http://codepen.io/SomeStuffer/pen/uwstc) by [SomeStuffer](http://codepen.io/SomeStuffer/)
