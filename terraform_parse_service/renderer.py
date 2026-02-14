from jinja2 import Environment, FileSystemLoader

class TerraformRenderer:
    def __init__(self, template_dir='templates'):
        # 1. Specify the path where the template is stored
        self.loader = FileSystemLoader(template_dir)
        # 2. Initialize Jinja2 environment
        self.env = Environment(loader=self.loader)

    def render_s3(self, props):
        # 3. Load the specified .j2 file
        template = self.env.get_template('s3_bucket.tf.j2')
        
        # 4. Fill in the data into the template and return the string
        # The Key (region, bucket_name) here must be consistent with the one in the .j2 file
        return template.render(
            region=props.get('aws-region'),
            bucket_name=props.get('bucket-name'),
            acl=props.get('acl')
        )