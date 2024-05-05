import lifegame

import std/data/linearset
import std/test

fun test-neighbors()
  basic/test("Basics")
    val result = neighbors(Point(1, 2))
    expect(8, { result.length })
    expect(Just(Point(0, 1)), { result[0] })
    expect(Just(Point(1, 1)), { result[1] })
    expect(Just(Point(2, 1)), { result[2] })
    expect(Just(Point(0, 2)), { result[3] })
    expect(Just(Point(2, 2)), { result[4] })
    expect(Just(Point(0, 3)), { result[5] })
    expect(Just(Point(1, 3)), { result[6] })
    expect(Just(Point(2, 3)), { result[7] })

fun test-is-living()
  basic/test("3 living neighbors")
    val result = is-living(
      Point(1, 2),
      living-cells([
        Point(0, 1),
        Point(1, 1),
        Point(2, 1),
      ]))
    expect(True, { result })
  basic/test("2 living neighbors and self is dead")
    val result = is-living(
      Point(1, 2),
      living-cells([
        Point(0, 1),
        Point(1, 1),
      ]))
    expect(False, { result })
  basic/test("2 living neighbors and self is living")
    val result = is-living(
      Point(1, 2),
      living-cells([
        Point(0, 1),
        Point(1, 1),
        Point(1, 2),
      ]))
    expect(True, { result })

fun test-next-generation()
  basic/test("Basics")
    val input = living-cells([
      Point(3, 2),
      Point(4, 3),
      Point(2, 4),
      Point(3, 4),
      Point(4, 4),
    ])

    val result = next-generation(input)
    expect(5, { result.length })
    expect(False, { result.member(Point(3, 2)) })
    expect(True, { result.member(Point(2, 3)) })
    expect(True, { result.member(Point(4, 3)) })
    expect(False, { result.member(Point(2, 4)) })
    expect(True, { result.member(Point(3, 4)) })
    expect(True, { result.member(Point(4, 4)) })
    expect(True, { result.member(Point(3, 5)) })

pub fun main()
  test-neighbors()
  test-is-living()
  test-next-generation()
