import colors

type Renderable* = object of Rootobj # Todo: concepts?
  color*: Color
  pos*: tuple[x,y:float]
  scale*: float
  rot*: float 
  origin*: tuple[x,y:float]
  centered*: bool

type Rect* = object of Renderable
  ## A rectangle. For filled rectangles see box.
  size*: tuple[w,h:float]

type Box* = object of Renderable
  ## A filled rectangle
  size*: tuple[w,h:float]

type Circle* = object of Renderable
  ## A circle. For filled circles see disk.
  radius*: float

type Disk* = object of Renderable
  ## A filled circle.
  radius*: float

type Polygon* = object of Renderable
  ## A polygon. ``bcradius`` is the radius of the bounding circle.  
  ## If ``filled`` is true, then the polygon is filled (duh).
  sides*: int
  bcradius*:float
  filled*:bool

type Batcher = object
  r: seq[Rect]
  b: seq[Box]
  c: seq[Circle]
  d: seq[Disk]
  p: seq[Polygon]

proc batcher():Batcher= 
  Batcher(r: newSeq[Rect](),
          b: newSeq[Box](),
          c: newSeq[Circle](),
          d: newSeq[Disk](),
          p: newSeq[Polygon]())

proc add[K](b:var Batcher,rend:K)=
  if rend is Box:
    echo rend is Box
    b.b.add(rend)
#[  if rend is Box:
    b.b.add(rend)
  if rend is Circle:
    b.c.add(rend)
  if rend is Disk:
    b.d.add(rend)
  if rend is Polygon:
    b.p.add(rend)
  #else: echo "unknown render primitive"]#

type Renderables* = Rect|Box|Circle|Disk|Polygon

proc rect*(
    x,y:float=0.0,
    w,h:float=10.0,
    color:Color=Red,
    centered:bool=true
  ):Rect =
  result.color = color
  result.pos = (x,y)
  result.size=(w,h)
  #result.origin = (-w/2,-h/2) # default to centered for consistency
  result.scale = 1.0
  result.centered =  centered

proc box*(x,y:float=0.0,w,h:float=10.0,color:Color=Red,centered:bool=true):Box =
  result.color = color
  result.pos = (x,y)
  #result.origin = (-w/2,-h/2)
  result.size=(w,h)
  result.scale = 1.0
  result.centered = centered

proc circle*(x,y:float=0.0,r:float=10.0,color:Color=Red):Circle =
  result.color = color
  result.pos = (x,y)
  result.radius = r 
  result.scale = 1.0

proc disk*(x,y:float=0.0,r:float=10.0,color:Color=Red):Disk =
  result.color = color
  result.pos = (x,y)
  result.radius = r 
  result.scale = 1.0

proc polygon* (
    x,y:float=0.0,
    sides:int=3,
    boundingcircleradius:float=10.0,
    filled:bool=false,
    color:Color=Red
  ) : Polygon =
  
  doassert(sides>=3)
  result.color = color
  result.pos = (x,y)
  result.sides = sides
  result.bcradius = boundingcircleradius
  result.filled = filled
  result.scale = 1.0

when isMainModule:
  var b = batcher()
  b.add(rect())
