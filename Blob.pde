class Blob
{
  // Genotype
  DNA dna;
  int geneForceIndex;
  float fitness;
  float OBSTACLE_DETERRENT = 0.1;
  float TARGET_REWARD = 1.5;

  // Phenotype
  PVector startLocation = new PVector(width / 2, height - 50);
  PVector location;
  PVector velocity;
  PVector acceleration;
  int r = 10;
  int redValue = 255;
  boolean is_at_target;
  boolean has_collided;

  Blob()
  {
    location = startLocation;
    velocity = new PVector();
    acceleration = new PVector();
    dna = new DNA();
    geneForceIndex = 0;
    is_at_target = false;
    has_collided = false;
    display();
  }

  Blob(DNA new_genes)
  {
    this.location = startLocation;
    this.velocity = new PVector();
    this.acceleration = new PVector();
    this.dna = new_genes;
    this.geneForceIndex = 0;
    this.is_at_target = false;
    this.has_collided = false;
    display();
  }

  void step()
  {
    at_target();
    check_for_obstacles();
    if (!is_at_target && !has_collided) {
      applyForce(this.dna.genes[geneForceIndex]);
      geneForceIndex = (geneForceIndex + 1) % this.dna.genes.length;
    }
    display();
  }

  void applyForce(PVector force)
  {
    acceleration.add(force);
    updateBlob();
  }

  void updateBlob()
  {
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);
  }

  void fitness()
  {
    float d = dist(location.x, location.y, target.x, target.y);
    fitness = pow(1 / d, 2);
    if (has_collided)
      fitness *= OBSTACLE_DETERRENT;
    if (this.is_at_target)
      fitness *= TARGET_REWARD;
  }

  void at_target()
  {
    if (dist(location.x, location.y, target.x, target.y) < 10)
      is_at_target = true;
  }
  
  void check_for_obstacles()
  {
    for (Obstacle obs : obstacles)
    {
      if (obs.contains(this.location))
        has_collided = true;
    }
  }

  void display()
  {
    fill(redValue, 0, 0);
    stroke(redValue, 0, 0);
    ellipse(location.x, location.y, r, r);
  }
}