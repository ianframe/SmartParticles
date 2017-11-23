int current_life = 0;
int LIFETIME = 400;
int POPULATION_SIZE = 50;
float MUTATION_RATE = 0.01;

Population generalPop;
PVector target;

ArrayList<Obstacle> obstacles;

PFont font;

void setup()
{
  size(800, 500);
  
  generalPop = new Population(POPULATION_SIZE, MUTATION_RATE);
  
  obstacles = new ArrayList<Obstacle>();
  obstacles.add(new Obstacle(new PVector(width/2 - 150, height/2 - 12), 25, 300));
  
  font = createFont("GlacialIndifference-Regular", 24);
  fill(255);
  textFont(font);
  background(0);
  target = new PVector(width / 2, 50);
  paintStaticPieces();
}

void draw()
{
  if (current_life++ < LIFETIME) {
    paintStaticPieces();
    display_stats();
    generalPop.step_every_member();
  } else {
    current_life = 0;
    generalPop.calc_pop_fitness();
    generalPop.select();
    generalPop.reproduce();
  }
}

void mousePressed()
{
  target.x = mouseX;
  target.y = mouseY;
  generalPop.generations = 0;
}

void paintStaticPieces()
{
  background(0);
  stroke(0, 255, 0); 
  fill(0, 255, 0);
  ellipse(target.x, target.y, 25, 25);
  stroke(255);
  fill(255);
  for (Obstacle obs : obstacles)
    rect(obs.location.x, obs.location.y, obs.w, obs.h);
}

void display_stats()
{
  fill(255);
  textSize(28);
  text("Generation", 10, 50);
  textSize(14);
  text(generalPop.generations, 10, 75);
}