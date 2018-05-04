import UIKit
import FoldingCell
import EasyPeasy

class GithubFoldingCell: FoldingCell {
    
    var repoFold: RepoFold?
    var repoUnfold: RepoUnfold?
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        repoFold = createRepoFold()
        repoUnfold = createRepoUnfold()
        containerView = createContainerView(view: repoUnfold!)
        foregroundView = createForegroundView(view: repoFold!)
        self.backgroundColor = UIColor(red:0.96, green:0.96, blue:0.96, alpha:1.0)
        // super class method configure views
        commonInit()
    }
    
    var repository: Repository? {
        didSet {
            repoFold?.repositoryName.text = repository?.name
            repoFold?.repositoryDescription.text = repository?.description
            
            repoUnfold?.repositoryName.text = repository?.name
            repoUnfold?.repositoryDescription.text = repository?.description
            repoUnfold?.repositorySize.text = repository!.size.map(String.init) ?? ""
            repoUnfold?.repositoryLanguage.text = repository?.language
            repoUnfold?.repositoryUrl.text = repository?.url
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func animationDuration(_ itemIndex: NSInteger, type: FoldingCell.AnimationType) -> TimeInterval {
        // durations count equal it itemCount
        let durations = [0.33, 0.26, 0.26] // timing animation for each view
        return durations[itemIndex]
    }
}

// MARK: Configure

extension GithubFoldingCell {
    
    private func createRepoFold() -> RepoFold{
        let repoFold = RepoFold(frame: .zero)
        return repoFold
    }
    private func createRepoUnfold() -> RepoUnfold{
        let repoUnfold = RepoUnfold(frame: .zero)

        return repoUnfold
    }
    
    private func createForegroundView( view:UIView) -> RotatedView {
        
        let foregroundView = RotatedView(frame: .zero)
        foregroundView.translatesAutoresizingMaskIntoConstraints = false
        foregroundView.backgroundColor = UIColor.white
        foregroundView.addSubview(view)
        
        contentView.addSubview(foregroundView)
        
        // add constraints
        
        foregroundView.easy.layout(
            Height(75),
            Left(8),
            Right(8)
        )
        
        // add identifier
        let top = foregroundView.easy.layout(Top(8)).first
        top?.identifier = "foregroundViewTop"
        foregroundViewTop = top
        foregroundView.layoutIfNeeded()

        return foregroundView
    }
    
    private func createContainerView(view:RepoUnfold) -> UIView {
        let containerView = UIView(frame: .zero)
        containerView.translatesAutoresizingMaskIntoConstraints = false

        containerView.addSubview(view)
        containerView.backgroundColor = view.contentView.backgroundColor
        contentView.addSubview(containerView)
        
        // add constraints
        containerView.easy.layout(
            Height(CGFloat(75 * itemCount)),
            Left(8),
            Right(8)
        )
        
        // add identifier
        let top = containerView.easy.layout(Top(8)).first
        top?.identifier = "containerViewTop"
        containerViewTop = top
        containerView.layoutIfNeeded()
        
        return containerView
    }
}
