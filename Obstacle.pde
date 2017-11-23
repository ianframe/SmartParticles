// A class of rectangular obstacles

class Obstacle
{
  PVector location;
  float h, w;

  Obstacle(PVector location, float h, float w)
  {
    this.location = location;
    this.h = h;
    this.w = w;
  }

  boolean contains(PVector object)
  {
    return (object.x >= this.location.x && object.x <= this.location.x + this.w) &&
      (object.y >= this.location.y && object.y <= this.location.y + this.h);
  }
}