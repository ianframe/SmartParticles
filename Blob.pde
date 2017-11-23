class Blob
{
  // Genotype
  DNA dna;
  int geneForceIndex;
  float fitness;

  // Phenotype
  PVector startLocation = new PVector(width / 2, height - 50);
  PVector location;
  PVector velocity;
  PVector acceleration;
  int r = 10;
  int redValue = 255;
  boolean is_at_target;

  Blob()
  {
    location = startLocation;
    velocity = new PVector();
    acceleration = new PVector();
    dna = new DNA();
    geneForceIndex = 0;
    is_at_target = false;
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
    display();
  }

  void step()
  {
    at_target();
    if (!is_at_target) {
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
  }

  void at_target()
  {
    if (dist(location.x, location.y, target.x, target.y) < 10)
      is_at_target = true;
  }

  void display()
  {
    fill(redValue, 0, 0);
    stroke(redValue, 0, 0);
    ellipse(location.x, location.y, r, r);
  }
}