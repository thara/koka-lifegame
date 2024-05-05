import std/os/process

// https://github.com/koka-community/std/blob/main/std/data/linearset.kk
import std/data/linearset
import std/test

value struct point
  x: int
  y: int

fun point/show( p : point) : e string
   "{x=" ++ p.x.show ++ ", y=" ++ p.y.show ++ "}"

fun point/(==)( p1 : point, p2 : point ) : e bool
  p1.x == p2.x && p1.y == p2.y

fun neighbors(p: point) : list<point>
  [
    p(x = p.x - 1, y = p.y - 1),
    p(y = p.y - 1),
    p(x = p.x + 1, y = p.y - 1),
    p(x = p.x - 1),
    p(x = p.x + 1),
    p(x = p.x - 1, y = p.y + 1),
    p(y = p.y + 1),
    p(x = p.x + 1, y = p.y + 1),
  ]

alias livingCells = linearSet<point>

fun living-cells(a: list<point>) : livingCells
  linear-set(a, ?(==) = point/(==))

fun is-living(p: point, livings: livingCells) : bool
  val count = neighbors(p).filter(fn(p') livings.member(p')).length
  count == 3 || (count == 2 && livings.member(p))

fun next-generation(livings: livingCells) : livingCells
  val result = livings.foldl([],
    fn(lx, e) -> lx.append(neighbors(e))
  ).filter(fn(p) is-living(p, livings))
  linear-set(result, ?(==) = point/(==))

fun render(livings: livingCells) : console ()
  for(0, 15) fn(y)
    for(0, 30) fn(x)
      val p = Point(x, y)
      print(if livings.member(p, ?(==) = point/(==)) then "*" else ".")
    println("")

pub fun main()
  val initial = living-cells([
      // glider
      Point(0, 1),
      Point(1, 2),
      Point(2, 0),
      Point(2, 1),
      Point(2, 2)
    ])

  var current := initial
  current.render()

  while { True }
    run-system("sleep 0.3")
    print("\x1b[16A\r")

    current := next-generation(current)
    current.render()

